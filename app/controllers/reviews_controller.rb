class ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user, :event)
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @event = Event.find(review_params[:event_id])
    @user = User.find_by(id: review_params[:user_id])

    if @user.blank?
      redirect_to @event, alert: "Please select a user."
    elsif !@event.completed?
      redirect_to @event, alert: "Reviews can only be added to completed events."
    elsif !Registration.confirmed.exists?(user: @user, event: @event)
      redirect_to @event, alert: "Only users with a confirmed registration can review this event."
    elsif Review.exists?(user: @user, event: @event)
      redirect_to @event, alert: "This user has already reviewed this event."
    else
      @review = Review.new(review_params)

      if @review.save
        redirect_to @event, notice: "Review was successfully created."
      else
        redirect_to @event, alert: @review.errors.full_messages.to_sentence
      end
    end
  end

  
  private

  def review_params
    params.require(:review).permit(:user_id, :event_id, :rating, :comment)
  end
end