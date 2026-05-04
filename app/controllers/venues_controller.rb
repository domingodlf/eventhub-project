class VenuesController < ApplicationController
  def index
    @venues = Venue.includes(:events)
  end

  def show
    @venue = Venue.find(params[:id])
  end
end