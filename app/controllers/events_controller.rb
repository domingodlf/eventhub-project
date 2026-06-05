class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :publish]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish]
  before_action :load_form_collections, only: [:new, :edit, :create, :update]

  def index
    @events = Event.accessible_by(current_ability).includes(:organizer, :category, :venue)
  end

  def show
    authorize! :read, @event

    @registration = Registration.new
    @review = Review.new
    @users = User.all
    @registrations = @event.registrations.includes(:user).order(:registered_at)
    @reviews = @event.reviews.includes(:user).order(created_at: :desc)
  end

  def new
    @event = Event.new
    authorize! :create, @event
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user
    @event.status = "draft"

    authorize! :create, @event

    if @event.save
      redirect_to @event, notice: "Event was successfully created as a draft."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @event
  end

  def update
    authorize! :update, @event

    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def publish
    authorize! :publish, @event

    if @event.draft?
      @event.update(status: "published")
      redirect_to @event, notice: "Event was successfully published."
    else
      redirect_to @event, alert: "Only draft events can be published."
    end
  end

  def destroy
    authorize! :destroy, @event

    if @event.draft? || @event.published?
      @event.update(status: "cancelled")
      redirect_to @event, notice: "Event was successfully cancelled."
    else
      redirect_to @event, alert: "Only draft or published events can be cancelled."
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def load_form_collections
    @categories = Category.all
    @venues = Venue.all
  end

  def event_params
    params.require(:event).permit(:title, :description, :category_id, :venue_id, :start_time, :end_time, :max_attendees)
  end
end