class Venue < ApplicationRecord
  has_many :events

  validates :name, presence: true
  validates :building, presence: true
  validates :address, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
