class EventsController < ApplicationController
  def index
    @events = Event.includes(:organizer, :category, :venue)
  end

  def show
    @event = Event.find(params[:id])
  end
end