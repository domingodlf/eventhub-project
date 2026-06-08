# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


### CLEAN DATABASE

Review.destroy_all
Registration.destroy_all
Event.destroy_all
Venue.destroy_all
Category.destroy_all
User.destroy_all


### USERS

default_password = "password123"

user1 = User.create!(
  first_name: "Gustabo",
  last_name: "Garcia",
  email: "admin@eventhub.com",
  password: default_password,
  password_confirmation: default_password,
  role: "admin"
)

user2 = User.create!(
  first_name: "Lucas",
  last_name: "Fernandez",
  email: "lucas.fernandez@eventhub.cl",
  password: default_password,
  password_confirmation: default_password,
  role: "regular"
)

user3 = User.create!(
  first_name: "Valentina",
  last_name: "Rojas",
  email: "valentina.rojas@eventhub.cl",
  password: default_password,
  password_confirmation: default_password,
  role: "regular"
)

user4 = User.create!(
  first_name: "Tomas",
  last_name: "Silva",
  email: "tomas.silva@eventhub.cl",
  password: default_password,
  password_confirmation: default_password,
  role: "regular"
)

user5 = User.create!(
  first_name: "Camila",
  last_name: "Torres",
  email: "camila.torres@eventhub.cl",
  password: default_password,
  password_confirmation: default_password,
  role: "regular"
)

user6 = User.create!(
  first_name: "Diego",
  last_name: "Herrera",
  email: "diego.herrera@eventhub.cl",
  password: default_password,
  password_confirmation: default_password,
  role: "regular"
)

user7 = User.create!(
  first_name: "Antonia",
  last_name: "Vargas",
  email: "antonia.vargas@eventhub.cl",
  password: default_password,
  password_confirmation: default_password,
  role: "regular"
)


### CATEGORIES

category1 = Category.create!(
  name: "Sports",
  description: "Events related to physical activity, team sports, tournaments, and outdoor movement."
)

category2 = Category.create!(
  name: "Study",
  description: "Academic events, study groups, workshops, and collaborative learning sessions."
)

category3 = Category.create!(
  name: "Arts & Culture",
  description: "Creative, cultural, musical, and artistic events for the university community."
)

category4 = Category.create!(
  name: "Outdoors & Adventures",
  description: "Outdoor activities, hikes, trips, and experiences outside the classroom."
)


### VENUES

venue1 = Venue.create!(
  name: "Main Auditorium",
  building: "Central Building",
  address: "Campus Central, Av. Universidad 1000",
  capacity: 120
)

venue2 = Venue.create!(
  name: "Sports Court",
  building: "Sports Center",
  address: "Campus Sports Area, Court 1",
  capacity: 80
)

venue3 = Venue.create!(
  name: "Library Study Room",
  building: "Library",
  address: "Library Building, Second Floor",
  capacity: 30
)

venue4 = Venue.create!(
  name: "Arts Hall",
  building: "Student Center",
  address: "Student Center, Room 204",
  capacity: 50
)

venue5 = Venue.create!(
  name: "Outdoor Meeting Point",
  building: "Main Entrance",
  address: "Campus Main Entrance",
  capacity: 40
)


### EVENTS

event1 = Event.create!(
  organizer: user2,
  category: category2,
  venue: venue3,
  title: "Finals Study Session",
  description: "A collaborative study session to prepare for final exams with shared notes and peer support.",
  start_time: Time.new(2026, 4, 10, 15, 0),
  end_time: Time.new(2026, 4, 10, 17, 0),
  max_attendees: 25,
  status: "completed"
)

event2 = Event.create!(
  organizer: user3,
  category: category3,
  venue: venue4,
  title: "Acoustic Music Evening",
  description: "An informal evening where students performed acoustic songs and shared original music.",
  start_time: Time.new(2026, 4, 15, 18, 30),
  end_time: Time.new(2026, 4, 15, 20, 30),
  max_attendees: 45,
  status: "completed"
)

event3 = Event.create!(
  organizer: user2,
  category: category1,
  venue: venue2,
  title: "Interfaculty Football Match",
  description: "A friendly football match between students from different faculties.",
  start_time: Time.new(2026, 5, 8, 16, 0),
  end_time: Time.new(2026, 5, 8, 18, 0),
  max_attendees: 60,
  status: "published"
)

event4 = Event.create!(
  organizer: user3,
  category: category4,
  venue: venue5,
  title: "Saturday Hiking Trip",
  description: "A guided hiking trip for students who want to spend the day outdoors and meet new people.",
  start_time: Time.new(2026, 5, 17, 8, 30),
  end_time: Time.new(2026, 5, 17, 15, 30),
  max_attendees: 35,
  status: "published"
)

event5 = Event.create!(
  organizer: user1,
  category: category2,
  venue: venue1,
  title: "Web Technologies Workshop",
  description: "A practical workshop about Rails, databases, and web application development.",
  start_time: Time.new(2026, 5, 4, 15, 0),
  end_time: Time.new(2026, 5, 4, 18, 0),
  max_attendees: 100,
  status: "ongoing"
)

event6 = Event.create!(
  organizer: user2,
  category: category3,
  venue: venue4,
  title: "Photography Walk",
  description: "A planned photography activity around campus. Details will be confirmed soon.",
  start_time: Time.new(2026, 5, 25, 11, 0),
  end_time: Time.new(2026, 5, 25, 13, 0),
  max_attendees: 20,
  status: "draft"
)

event7 = Event.create!(
  organizer: user3,
  category: category1,
  venue: venue2,
  title: "Basketball Skills Clinic",
  description: "A basketball training session that was cancelled due to scheduling conflicts.",
  start_time: Time.new(2026, 5, 12, 17, 0),
  end_time: Time.new(2026, 5, 12, 19, 0),
  max_attendees: 40,
  status: "cancelled"
)


### REGISTRATIONS

Registration.create!(
  user: user4,
  event: event1,
  status: "confirmed",
  registered_at: Time.new(2026, 4, 5, 12, 0)
)

Registration.create!(
  user: user5,
  event: event1,
  status: "confirmed",
  registered_at: Time.new(2026, 4, 6, 10, 30)
)

Registration.create!(
  user: user6,
  event: event2,
  status: "confirmed",
  registered_at: Time.new(2026, 4, 12, 9, 0)
)

Registration.create!(
  user: user7,
  event: event2,
  status: "confirmed",
  registered_at: Time.new(2026, 4, 13, 14, 0)
)

Registration.create!(
  user: user4,
  event: event3,
  status: "confirmed",
  registered_at: Time.new(2026, 4, 25, 11, 0)
)

Registration.create!(
  user: user5,
  event: event3,
  status: "waitlisted",
  registered_at: Time.new(2026, 4, 26, 13, 0),
  waitlist_position: 1
)

Registration.create!(
  user: user6,
  event: event4,
  status: "confirmed",
  registered_at: Time.new(2026, 4, 28, 15, 30)
)

Registration.create!(
  user: user7,
  event: event4,
  status: "waitlisted",
  registered_at: Time.new(2026, 4, 29, 16, 0),
  waitlist_position: 1
)

Registration.create!(
  user: user4,
  event: event5,
  status: "confirmed",
  registered_at: Time.new(2026, 5, 1, 9, 0)
)

Registration.create!(
  user: user5,
  event: event7,
  status: "cancelled",
  registered_at: Time.new(2026, 4, 20, 10, 0)
)


### REVIEWS

Review.create!(
  user: user4,
  event: event1,
  rating: 5,
  comment: "The study session was very helpful and well organized."
)

Review.create!(
  user: user5,
  event: event1,
  rating: 4,
  comment: "Good environment to study and share notes with other students."
)

Review.create!(
  user: user6,
  event: event2,
  rating: 5,
  comment: "Great atmosphere and very talented performers."
)

Review.create!(
  user: user7,
  event: event2,
  rating: 4,
  comment: "A fun cultural event with a relaxed community feeling."
)