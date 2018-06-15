class CreatePassengerTaxis < ActiveRecord::Migration
  def change
    create_table :passenger_taxis do |t|
      t.integer :passenger_id
      t.integer :taxi_id

      t.timestamps null: false
    end
  end
end
