class CreateRides < ActiveRecord::Migration[5.1]
  def change
    create_table :rides do |t|
      t.integer :user_id
      t.integer :attraction_id
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
