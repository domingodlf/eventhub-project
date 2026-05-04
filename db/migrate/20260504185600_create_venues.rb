class CreateVenues < ActiveRecord::Migration[8.1]
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.string :building, null: false
      t.string :address, null: false
      t.integer :capacity, null: false

      t.timestamps
    end

    add_check_constraint :venues, "capacity > 0", name: "venues_capacity_positive"
  end
end