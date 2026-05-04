class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.includes(:user, :event)
  end

  def show
    @registration = Registration.find(params[:id])
  end
end