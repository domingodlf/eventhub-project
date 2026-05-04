class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.integer :rating, null: false
      t.text :comment, null: false

      t.timestamps
    end

    add_foreign_key :reviews, :users
    add_foreign_key :reviews, :events

    add_index :reviews, [:user_id, :event_id], unique: true
    add_check_constraint :reviews, "rating >= 1 AND rating <= 5", name: "reviews_rating_between_1_and_5"
  end
end