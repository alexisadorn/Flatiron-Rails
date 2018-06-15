require 'rails_helper'

describe Reservation do
  let(:nyc) { City.create(name: 'NYC') }
  let(:fidi) { Neighborhood.create(name: 'Fi Di', city: nyc) }
  let(:amanda) { User.create(name: "Amanda") }
  let(:logan) { User.create(name: "Logan") }
  let(:listing) do
    Listing.create(
      address: '123 Main Street',
      listing_type: "private room",
      title: "Beautiful Apartment on Main Street",
      description: "My apartment is great. there's a bedroom. close to subway....blah blah",
      price: 50.00,
      neighborhood: fidi,
      host: amanda
    )
  end
  let(:reservation) do
    Reservation.create(
      checkin: '2014-04-25',
      checkout: '2014-04-30',
      listing: listing,
      guest: logan
    )
  end

  it 'has a checkin time' do
    expect(reservation.checkin).to eq(Date.parse('2014-04-25'))
  end

  it 'has a checkout time' do
    expect(reservation.checkout).to eq(Date.parse('2014-04-30'))
  end

  it 'belongs to a guest' do
    expect(reservation.guest).to eq(logan)
  end

  it 'belongs to a listing' do
    expect(reservation.listing).to eq(listing)
  end
end
