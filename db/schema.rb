# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_04_185645) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.datetime "end_time", null: false
    t.integer "max_attendees", null: false
    t.integer "organizer_id", null: false
    t.datetime "start_time", null: false
    t.string "status", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "venue_id", null: false
    t.check_constraint "end_time > start_time", name: "events_end_time_after_start_time"
    t.check_constraint "max_attendees > 0", name: "events_max_attendees_positive"
    t.check_constraint "status::text = ANY (ARRAY['draft'::character varying, 'published'::character varying, 'ongoing'::character varying, 'completed'::character varying, 'cancelled'::character varying]::text[])", name: "events_status_check"
  end

  create_table "registrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "event_id", null: false
    t.datetime "registered_at", null: false
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "waitlist_position"
    t.index ["user_id", "event_id"], name: "index_registrations_on_user_id_and_event_id", unique: true
    t.check_constraint "status::text = ANY (ARRAY['confirmed'::character varying, 'waitlisted'::character varying, 'cancelled'::character varying]::text[])", name: "registrations_status_check"
    t.check_constraint "waitlist_position IS NULL OR waitlist_position > 0", name: "registrations_waitlist_position_positive"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.integer "event_id", null: false
    t.integer "rating", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id", "event_id"], name: "index_reviews_on_user_id_and_event_id", unique: true
    t.check_constraint "rating >= 1 AND rating <= 5", name: "reviews_rating_between_1_and_5"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "role", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.check_constraint "role::text = ANY (ARRAY['regular'::character varying, 'admin'::character varying]::text[])", name: "users_role_check"
  end

  create_table "venues", force: :cascade do |t|
    t.string "address", null: false
    t.string "building", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "capacity > 0", name: "venues_capacity_positive"
  end

  add_foreign_key "events", "categories"
  add_foreign_key "events", "users", column: "organizer_id"
  add_foreign_key "events", "venues"
  add_foreign_key "registrations", "events"
  add_foreign_key "registrations", "users"
  add_foreign_key "reviews", "events"
  add_foreign_key "reviews", "users"
end
