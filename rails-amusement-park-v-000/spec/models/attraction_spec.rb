require 'rails_helper'

RSpec.describe Attraction, :type => :model do
  let(:attraction) {
    Attraction.create(
      :name => "Roller Coaster",
      :tickets => 5,
      :nausea_rating => 2,
      :happiness_rating => 4,
      :min_height => 32
    )
  }

  it "is valid with a name, min_height, nausea_rating, happiness_rating, and ticket number" do
    expect(attraction).to be_valid
  end

  it "has many rides" do
    user = User.create(name: "Max Charles", password: "password")
    ride = Ride.create(user_id: user.id, attraction_id: attraction.id)
    expect(attraction.rides.first).to eq(ride)
  end

  it "has many users through rides" do
    max = User.create(name: "Max Charles", password: "password")
    skai = User.create(name: "Skai Jackson", password: "password")
    attraction.users << [max, skai]

    expect(attraction.users.first).to eq(max)
    expect(attraction.users.last).to eq(skai)
  end

end
