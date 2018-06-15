require 'rails_helper'

describe Neighborhood do
  let(:nyc) { City.create(name: 'NYC') }
  let(:brighton_beach) { Neighborhood.create(name: 'Brighton Beach', city: nyc) }

  it 'has a name' do
    expect(brighton_beach.name).to eq('Brighton Beach')
  end

  it 'belongs to a city' do
    expect(brighton_beach.city).to be(nyc)
  end

  context "listings" do
    let(:user) { User.create(name: "Arel") }
    let!(:listing) do
      Listing.create(
        address: '44 Ridge Lane',
        listing_type: "whole house",
        title: "Beautiful Home on Mountain",
        description: "Whole house for rent on mountain. Many bedrooms.",
        price: 200.00,
        neighborhood: brighton_beach,
        host: user
      )
    end

    it 'has many listings' do
      expect(brighton_beach.listings).to eq([listing])
    end
  end
end
