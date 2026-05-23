class Event < ApplicationRecord
  has_rich_text :description

  belongs_to :organizer, class_name: "User"
  belongs_to :category
  belongs_to :venue
  has_many :registrations
  has_many :reviews

  enum :status, {
    draft: "draft",
    published: "published",
    ongoing: "ongoing",
    completed: "completed",
    cancelled: "cancelled"
  }

  validates :title, presence: true
  validates :description, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :max_attendees, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :status, presence: true
  validates :organizer, presence: true
  validates :category, presence: true
  validates :venue, presence: true

  validate :end_time_after_start_time
  validate :max_attendees_within_venue_capacity

  scope :upcoming, -> { where("start_time > ?", Time.current).order(start_time: :asc) }
  scope :past, -> { where("end_time < ?", Time.current).order(end_time: :desc) }

  private

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def max_attendees_within_venue_capacity
    return if max_attendees.blank? || venue.blank? || venue.capacity.blank?

    if max_attendees > venue.capacity
      errors.add(:max_attendees, "cannot exceed venue capacity")
    end
  end
end
