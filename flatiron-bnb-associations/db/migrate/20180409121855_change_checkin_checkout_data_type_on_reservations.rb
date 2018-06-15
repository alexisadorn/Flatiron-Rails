class ChangeCheckinCheckoutDataTypeOnReservations < ActiveRecord::Migration
  def change
    change_column :reservations, :checkin, :datetime
    change_column :reservations, :checkout, :datetime
  end
end
