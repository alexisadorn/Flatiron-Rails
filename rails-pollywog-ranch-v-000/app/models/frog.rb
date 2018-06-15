class Frog < ActiveRecord::Base
  belongs_to :pond
  has_many :tadpoles
end
