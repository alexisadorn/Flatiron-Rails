class Taxi < ActiveRecord::Base
  has_many :rides
  has_many :passengers, through: :rides
end
