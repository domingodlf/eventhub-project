class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :organized_events, class_name: "Event", foreign_key: "organizer_id"
  has_many :registrations
  has_many :reviews

  enum :role, {
    regular: "regular",
    admin: "admin"
  }

  before_validation :normalize_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true

  private

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end
end
