class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date, end_date)
  end

  def self.highest_ratio_res_to_listings
    # Denver: 6 reservations, 1 listing
    # NYC: 4 reserations, 3 listings
    # SF: 1 listing, 1 reservation
    cities = self.all
    highest_city_num = 0
    highest_city_id = 0

    cities.each do |c|
      listing_count = c.listings.count
      reservation_count = 0
      c.listings.each do |listing|
        reservation_count += listing.reservations.count
      end

      ratio = reservation_count.to_f / listing_count.to_f

      if ratio > highest_city_num
        highest_city_id = c.id
      end
    end
    self.find(highest_city_id)
  end

  def most_res
  end
end
