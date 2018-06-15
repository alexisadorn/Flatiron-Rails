require 'rails_helper'

RSpec.describe Artist, type: :model do
  before do
    Artist.destroy_all
    Song.destroy_all
    @artist = Artist.create!(name: "Daft Punk")
    @grid = @artist.songs.create!(title: "The Grid")
    @voyager = @artist.songs.create!(title: "Voyager")
  end

  it "counts the songs" do
    expect(@artist.song_count).to eq(2)
  end
end
