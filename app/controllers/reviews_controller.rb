class ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user, :event)
  end

  def show
    @review = Review.find(params[:id])
  end
end