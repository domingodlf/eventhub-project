class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.includes(:user, :event)
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def create
    @event = Event.find(registration_params[:event_id])
    @user = User.find_by(id: registration_params[:user_id])

    if @user.blank?
      redirect_to @event, alert: "Please select a user."
    elsif !@event.published?
      redirect_to @event, alert: "Users can only register for published events."
    elsif Registration.exists?(user: @user, event: @event)
      redirect_to @event, alert: "This user is already registered for this event."
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

    if @registration.cancelled?
      redirect_to @event, alert: "This registration is already cancelled."
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
    params.require(:registration).permit(:user_id, :event_id)
  end
end