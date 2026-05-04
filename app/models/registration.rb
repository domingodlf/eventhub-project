class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, {
    confirmed: "confirmed",
    waitlisted: "waitlisted",
    cancelled: "cancelled"
  }

  validates :user, presence: true
  validates :event, presence: true
  validates :status, presence: true
  validates :registered_at, presence: true
  validates :user_id, uniqueness: { scope: :event_id }
  validates :waitlist_position, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  validate :waitlist_position_matches_status

  private

  def waitlist_position_matches_status
    if waitlisted? && waitlist_position.blank?
      errors.add(:waitlist_position, "must be present for waitlisted registrations")
    elsif !waitlisted? && waitlist_position.present?
      errors.add(:waitlist_position, "must only be used for waitlisted registrations")
    end
  end
end
