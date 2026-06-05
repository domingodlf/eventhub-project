class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    authorize! :read, Review
    @reviews = Review.includes(:user, :event)
  end

  def show
    @review = Review.find(params[:id])
    authorize! :read, @review
  end

  def create
    @event = Event.find(review_params[:event_id])

    if !@event.completed?
      redirect_to @event, alert: "Reviews can only be added to completed events."
    elsif !Registration.confirmed.exists?(user: current_user, event: @event)
      redirect_to @event, alert: "Only users with a confirmed registration can review this event."
    elsif Review.exists?(user: current_user, event: @event)
      redirect_to @event, alert: "You have already reviewed this event."
    else
      @review = Review.new(review_params)
      @review.user = current_user

      authorize! :create, @review

      if @review.save
        redirect_to @event, notice: "Review was successfully created."
      else
        redirect_to @event, alert: @review.errors.full_messages.to_sentence
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:event_id, :rating, :comment)
  end
end