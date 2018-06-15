class Taxi < ActiveRecord::Base
  has_many :rides
  has_many :passenger_taxis
  has_many :passengers, through: :passenger_taxis
end
