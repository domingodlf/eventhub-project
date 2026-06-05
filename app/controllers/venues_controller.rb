class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, Venue
    @venues = Venue.includes(:events)
  end

  def show
    authorize! :read, @venue
  end

  def new
    @venue = Venue.new
    authorize! :create, @venue
  end

  def create
    @venue = Venue.new(venue_params)
    authorize! :create, @venue

    if @venue.save
      redirect_to @venue, notice: "Venue was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @venue
  end

  def update
    authorize! :update, @venue

    if @venue.update(venue_params)
      redirect_to @venue, notice: "Venue was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @venue

    @venue.destroy
    redirect_to venues_path, notice: "Venue was successfully deleted."
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :building, :address, :capacity)
  end
end