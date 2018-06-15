class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :checkin
      t.string :checkout
      t.integer :listing_id
      t.integer :guest_id

      t.timestamps null: false
    end
  end
end
