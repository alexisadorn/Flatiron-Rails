class Passenger < ActiveRecord::Base
  has_many :rides
  has_many :taxis, through: :rides
end
