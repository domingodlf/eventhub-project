class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :role, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_check_constraint :users, "role IN ('regular', 'admin')", name: "users_role_check"
  end
end