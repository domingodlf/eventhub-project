class CreateRegistrations < ActiveRecord::Migration[8.1]
  def change
    create_table :registrations do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.string :status, null: false
      t.datetime :registered_at, null: false
      t.integer :waitlist_position

      t.timestamps
    end

    add_foreign_key :registrations, :users
    add_foreign_key :registrations, :events

    add_index :registrations, [:user_id, :event_id], unique: true
    add_check_constraint :registrations, "status IN ('confirmed', 'waitlisted', 'cancelled')", name: "registrations_status_check"
    add_check_constraint :registrations, "waitlist_position IS NULL OR waitlist_position > 0", name: "registrations_waitlist_position_positive"
  end
end