class AddTripIdToTrips < ActiveRecord::Migration
  def change
    add_column :users, :trip_id, :integer
  end
end
