class Tadpole < ActiveRecord::Base
  belongs_to :frog
  delegate :pond, to: :frog
end
