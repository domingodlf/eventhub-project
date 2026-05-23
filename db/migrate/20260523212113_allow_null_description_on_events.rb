class AllowNullDescriptionOnEvents < ActiveRecord::Migration[8.1]
  def change
    change_column_null :events, :description, true
  end
end