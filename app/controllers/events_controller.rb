class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish]
  before_action :load_form_collections, only: [:new, :edit, :create, :update]

  def index
    @events = Event.includes(:organizer, :category, :venue)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.status = "draft"

    if @event.save
      redirect_to @event, notice: "Event was successfully created as a draft."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def publish
    if @event.draft?
      @event.update(status: "published")
      redirect_to @event, notice: "Event was successfully published."
    else
      redirect_to @event, alert: "Only draft events can be published."
    end
  end

  def destroy
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
    @users = User.all
    @categories = Category.all
    @venues = Venue.all
  end

  def event_params
    params.require(:event).permit(:title, :description, :organizer_id, :category_id, :venue_id, :start_time, :end_time, :max_attendees)
  end
end