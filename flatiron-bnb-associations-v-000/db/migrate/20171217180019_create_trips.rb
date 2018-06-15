class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|

      t.timestamps null: false
    end
  end
end
