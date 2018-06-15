require 'rails_helper'

describe Review do
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
  let(:review) do
    Review.create(
      description: "This place was great!",
      rating: 5,
      guest: logan,
      reservation: reservation
    )
  end

  it 'has a description' do
    expect(review.description).to eq("This place was great!")
  end

  it 'has a rating' do
    expect(review.rating).to eq(5)
  end

  it 'belongs to a guest' do
    expect(review.guest).to eq(logan)
  end

  it 'belongs to a reservation' do
    expect(review.reservation).to be(reservation)
  end
end
