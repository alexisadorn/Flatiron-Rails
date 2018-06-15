require 'rails_helper'

describe User do
  let(:katie) { User.create(name: "Katie") }

  it 'has a name' do
    expect(katie.name).to eq("Katie")
  end

  context "guest and host" do
    let(:nyc) { City.create(name: 'NYC') }
    let(:green_point) { Neighborhood.create(name: 'Green Point', city: nyc) }
    let(:listing) do
      Listing.create(
        address: '6 Maple Street',
        listing_type: "shared room",
        title: "Shared room in apartment",
        description: "share a room with me because I'm poor",
        price: 15.00,
        neighborhood: green_point,
        host: katie
      )
    end
    let(:logan) { User.create(name: "Logan") }
    let(:reservation) do
      Reservation.create(
        checkin: '2014-04-25',
        checkout: '2014-04-30',
        listing: listing,
        guest: logan
      )
    end

    context "as host" do
      it "has many listings" do
        expect(katie.listings).to include(listing)
      end

      it 'has many reservations through their listing' do
        expect(katie.reservations).to include(reservation)
      end
    end

    context "as guest" do
      let(:review) do
        Review.create(
          description: "Meh, the host I shared a room with snored.",
          rating: 3,
          guest: logan,
          reservation: reservation
        )
      end

      it 'has many trips' do
        expect(logan.trips).to include(reservation)
      end


      it 'has written many reviews' do
        expect(logan.reviews).to include(review)
      end
    end
  end
end
