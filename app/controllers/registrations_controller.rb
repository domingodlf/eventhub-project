class RegistrationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :cancel]

  def index
    @registrations = Registration.includes(:user, :event)
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def create
    @event = Event.find(registration_params[:event_id])
    @user = current_user

    if !@event.published?
      redirect_to @event, alert: "Users can only register for published events."
    elsif Registration.exists?(user: @user, event: @event)
      redirect_to @event, alert: "You are already registered for this event."
    else
      @registration = Registration.new(
        user: @user,
        event: @event,
        registered_at: Time.current
      )

      if @event.full?
        @registration.status = "waitlisted"
        @registration.waitlist_position = @event.next_waitlist_position
        success_message = "Registration was added to the waitlist."
      else
        @registration.status = "confirmed"
        success_message = "Registration was successfully confirmed."
      end

      if @registration.save
        redirect_to @event, notice: success_message
      else
        redirect_to @event, alert: @registration.errors.full_messages.to_sentence
      end
    end
  end

  def cancel
    @registration = Registration.find(params[:id])
    @event = @registration.event

    unless @registration.user == current_user
      redirect_to @event, alert: "You can only cancel your own registration."
      return
    end

    if @registration.cancelled?
      redirect_to @event, alert: "This registration is already cancelled."
      return
    end

    unless @event.published?
      redirect_to @event, alert: "Registrations can only be cancelled while the event is published."
      return
    end

    was_confirmed = @registration.confirmed?

    ActiveRecord::Base.transaction do
      @registration.update!(status: "cancelled", waitlist_position: nil)
      @event.promote_next_waitlisted_registration if was_confirmed
    end

    redirect_to @event, notice: "Registration was successfully cancelled."
  rescue ActiveRecord::RecordInvalid => error
    redirect_to @event, alert: error.record.errors.full_messages.to_sentence
  end

  private

  def registration_params
    params.require(:registration).permit(:event_id)
  end
end