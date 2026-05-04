class UsersController < ApplicationController
  def index
    @users = User.includes(:organized_events, :registrations, :reviews)
  end

  def show
    @user = User.find(params[:id])
  end
end