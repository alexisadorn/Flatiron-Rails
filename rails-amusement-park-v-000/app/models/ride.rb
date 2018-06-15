class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if missing_tickets && too_short
      "Sorry. " + ticket_message + " " + height_message
    elsif missing_tickets
      "Sorry. " + ticket_message
    elsif too_short
      "Sorry. " + height_message
    else
      go_on_ride
      "Thanks for riding the #{self.attraction.name}!"
    end
  end

  def missing_tickets
    self.user.tickets < self.attraction.tickets
  end

  def ticket_message
    "You do not have enough tickets to ride the #{self.attraction.name}."
  end

  def too_short
    self.user.height < self.attraction.min_height
  end

  def height_message
    "You are not tall enough to ride the #{self.attraction.name}."
  end

  def go_on_ride
    self.user.update(:tickets => (self.user.tickets - self.attraction.tickets),
                     :nausea => (self.user.nausea + self.attraction.nausea_rating),
                     :happiness => (self.user.happiness + self.attraction.happiness_rating)
                    )
  end

end
