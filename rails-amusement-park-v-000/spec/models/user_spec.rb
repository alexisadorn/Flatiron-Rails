require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) {
    User.create(
      :name => "Mindy",
      :password => "password",
      :nausea => 5,
      :happiness => 3,
      :tickets => 4,
      :height => 34
    )
  }

  let(:admin) {
    User.create(
      :name => "Walt",
      :password => "password",
      :nausea => 5,
      :happiness => 3,
      :tickets => 4,
      :height => 34,
      :admin => true
    )
  }

  let(:roller_coaster) {
    Attraction.create(
      :name => "Roller Coaster",
      :tickets => 5,
      :nausea_rating => 2,
      :happiness_rating => 4,
      :min_height => 32
    )
  }

  let(:ferris_wheel) {
    Attraction.create(
      :name => "Ferris Wheel",
      :tickets => 2,
      :nausea_rating => 2,
      :happiness_rating => 1,
      :min_height => 28
    )
  }

  it "is valid with a name, password, happiness, nausea, height, and tickets" do
    expect(user).to be_valid
  end

  it "is not valid without a password" do
    expect(User.new(name: "Name")).not_to be_valid
  end

  it "is valid with an admin boolean" do
    expect(admin).to be_valid
  end

  it "defaults to admin => false" do
    expect(user.admin).to eq(false)
  end

  it "has many rides" do
    first_ride = Ride.create(:user_id => user.id, :attraction_id => roller_coaster.id)
    second_ride = Ride.create(:user_id => user.id, :attraction_id => ferris_wheel.id)
    expect(user.rides.first).to eq(first_ride)
    expect(user.rides.last).to eq(second_ride)
  end

  it "has many attractions through rides" do
    user.attractions << [roller_coaster, ferris_wheel]
    expect(user.attractions.first).to eq(roller_coaster)
    expect(user.attractions.last).to eq(ferris_wheel)
  end

  it "has a method 'mood' that returns 'sad' when the user is more nauseous than happy" do
    expect(user.mood).to eq("sad")
  end

  it "has a method 'mood' that returns 'happy' when the user is more happy than nauseous" do
    user.update(:happiness => 7)
    expect(user.mood).to eq("happy")
  end

end
