class Attraction < ApplicationRecord
  has_many :rides
  has_many :users, through: :rides
end
