class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, presence: true
  validates :user_id, uniqueness: { scope: :event_id }

  validate :event_must_be_completed
  validate :user_must_have_confirmed_registration

  private

  def event_must_be_completed
    return if event.blank?

    unless event.completed?
      errors.add(:event, "must be completed before it can be reviewed")
    end
  end

  def user_must_have_confirmed_registration
    return if user.blank? || event.blank?

    unless Registration.confirmed.exists?(user: user, event: event)
      errors.add(:user, "must have a confirmed registration for this event")
    end
  end
end
