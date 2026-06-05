class UsersController < ApplicationController
  def index
    authorize! :index, User
    @users = User.includes(:organized_events, :registrations, :reviews)
  end

  def show
    @user = User.find(params[:id])
    authorize! :read, @user
  end
end