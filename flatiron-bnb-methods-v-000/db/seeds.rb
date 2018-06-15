
def make_seeds
  make_cities
  make_neighborhoods
  make_users
  make_listings
  make_reservations
  make_reviews
end

def make_cities
  ["New York City", "San Diego", "Woodstock"].each {|n| City.create(name: n) }
end

def make_neighborhoods
  ['Fi Di','Green Point','Brighton Beach','Pacific Heights','Mission District'].each do |name|
    Neighborhood.create(name: name, city_id: City.first.id)
  end
end

def make_users
  ["Amanda", "Katie","Arel","Logan","Tristan","Avi"].each do |name|
    User.create(name: name)
  end
end

def make_listings
  Listing.create(address: '123 Main Street', listing_type: "private room", title: "Beautiful Apartment on Main Street", description: "My apartment is great. there's a bedroom. close to subway....blah blah", price: 50.00, neighborhood_id: Neighborhood.first.id, host_id: User.first.id)
  Listing.create(address: '6 Maple Street', listing_type: "shared room", title: "Shared room in apartment", description: "shared a room with me because I'm poor", price: 15.00, neighborhood_id: Neighborhood.find_by(id: 2).id, host_id: User.find_by(id: 2).id)
  Listing.create(address: '44 Ridge Lane', listing_type: "whole house", title: "Beautiful Home on Mountain", description: "Whole house for rent on mountain. Many bedrooms.", price: 200.00, neighborhood_id: Neighborhood.find_by(id: 3).id, host_id: User.find_by(id: 3).id)
  Listing.create(address: '4782 Yaya Lane', listing_type: "private room", title: "Beautiful Room in awesome house", description: "Art collective hosue.", price: 400.00, neighborhood_id: Neighborhood.find_by(:name => "Pacific Heights").id, host_id: User.find_by(id: 3).id)
end

def make_reservations
  # first listing
  Reservation.create!(checkin: '2014-01-01', checkout: '2014-01-07', listing_id: 1, guest_id: User.last.id, :status => "accepted")
  Reservation.create!(checkin: '2014-01-09', checkout: '2014-01-20', listing_id: 1, guest_id: 5, :status => "accepted")
  Reservation.create!(checkin: '2014-04-25', checkout: '2014-04-30', listing_id: 1, guest_id: 4, :status => "accepted")
  # second listing 
  Reservation.create!(checkin: '2014-03-10', checkout: '2014-03-25', listing_id: Listing.find(2).id, guest_id: User.find_by(id: 5).id, :status => "accepted")
  # last listing
  Reservation.create!(checkin: '2014-06-02', checkout: '2014-06-30', listing_id: Listing.last.id, guest_id: User.find(6).id, :status => "accepted")
  Reservation.create!(checkin: '2014-05-15', checkout: '2014-06-01', listing_id: Listing.last.id, guest_id: User.find(5).id, :status => "accepted")
end

def make_reviews
  Review.create(description: "This place was great!", rating: 5, guest_id: User.find_by(id: 4).id, reservation_id: Reservation.first.id)
  Review.create(description: "Great place, close to subway!", rating: 4, guest_id: User.find_by(id: 5).id, reservation_id: Reservation.find_by(id: 2).id)
  Review.create(description: "Meh, the host I shared a room with snored.", rating: 3, guest_id: User.find_by(id: 6).id, reservation_id: Reservation.last.id)
end

make_seeds
