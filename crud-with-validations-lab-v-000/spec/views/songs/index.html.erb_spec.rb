require 'rails_helper'

RSpec.describe "songs/index", type: :feature do
  let(:song_attributes_1) do
    {
      title: "Rhythms Which I Played",
      release_year: 2000,
      released: true,
      genre: "Normcore",
      artist_name: "Man With Instruments"
    }
  end

  let(:song_attributes_2) do
    {
      title: "Rhythms Which I Played Again at a Later Time",
      release_year: 2004,
      released: true,
      genre: "Sci-Crust Fizz-Punk",
      artist_name: "Man With Instruments"
    }
  end

  before { Song.create!([song_attributes_1, song_attributes_2]) }

  it "renders a list of songs" do
    visit songs_path
    expect(all("tbody > tr").size).to eq(2)
  end
end
