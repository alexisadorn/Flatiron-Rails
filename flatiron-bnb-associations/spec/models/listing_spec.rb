require 'rails_helper'

describe Listing do
  let(:new_york_city) { City.create(name: 'NYC') }
  let(:financial_district) { Neighborhood.create(name: 'Fi Di', city: new_york_city) }
  let(:amanda) { User.create(name: "Amanda") }
  let(:logan) { User.create(name: "Logan") }
  let!(:listing) do
    Listing.create(
      address: '123 Main Street',
      listing_type: "private room",
      title: "Beautiful Apartment on Main Street",
      description: "My apartment is great. there's a bedroom. close to subway....blah blah",
      price: 50.00,
      neighborhood: financial_district,
      host: amanda
    )
  end

  it 'has a title' do
    expect(listing.title).to eq("Beautiful Apartment on Main Street")
  end

  it 'has a description' do
    expect(listing.description).to eq("My apartment is great. there's a bedroom. close to subway....blah blah")
  end

  it 'has an address' do
    expect(listing.address).to eq('123 Main Street')
  end

  it 'has a listing type' do
    expect(listing.listing_type).to eq("private room")
  end

  it 'has a price' do
    expect(listing.price).to eq(50.00)
  end

  it 'belongs to a neighborhood' do
    expect(listing.neighborhood.name).to eq("Fi Di")
  end

  it 'belongs to a host' do
    expect(listing.host.name).to eq("Amanda")
  end

  context 'reservations (and guests) and reviews' do
    let!(:reservation) do
      Reservation.create(
        checkin: '2014-04-25',
        checkout: '2014-04-30',
        listing: listing,
        guest: logan
      )
    end

    let!(:review) do
      Review.create(
        description: "This place was great!",
        rating: 5,
        guest: logan,
        reservation: reservation
      )
    end

    it 'has many reservations' do
      expect(listing.reservations).to include(reservation)
    end

    it 'has many reviews through reservations' do
      expect(listing.reviews).to include(review)
    end

    it 'knows about all of its guests' do
      expect(listing.guests).to include(logan)
    end
  end
end
