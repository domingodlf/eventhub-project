class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.integer :organizer_id, null: false
      t.integer :category_id, null: false
      t.integer :venue_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :max_attendees, null: false
      t.string :status, null: false

      t.timestamps
    end

    add_foreign_key :events, :users, column: :organizer_id
    add_foreign_key :events, :categories
    add_foreign_key :events, :venues

    add_check_constraint :events, "max_attendees > 0", name: "events_max_attendees_positive"
    add_check_constraint :events, "end_time > start_time", name: "events_end_time_after_start_time"
    add_check_constraint :events, "status IN ('draft', 'published', 'ongoing', 'completed', 'cancelled')", name: "events_status_check"
  end
end