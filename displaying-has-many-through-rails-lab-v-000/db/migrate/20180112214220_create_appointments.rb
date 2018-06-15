class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :appointment_datetime
      t.belongs_to :patient, index: true, foreign_key: true
      t.belongs_to :doctor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
