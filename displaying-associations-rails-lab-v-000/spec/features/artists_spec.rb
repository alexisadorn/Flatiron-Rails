require 'rails_helper'

describe "artists", type:  :feature do
  before do
    Artist.destroy_all
    Song.destroy_all
    @artist = Artist.create!(name: "Daft Punk")
    @grid = @artist.songs.create!(title: "The Grid")
    @voyager = @artist.songs.create!(title: "Voyager")
  end

  it "links to the artist's songs by title" do
    visit artist_path(@artist)
    expect(page).to have_link("The Grid", href: song_path(@grid))
  end

  it "lists all of the artist's songs" do
    visit artist_path(@artist)
    within("ul") do
      expect(page).to have_content("The Grid")
      expect(page).to have_content("Voyager")
    end
  end

  it "lists the artists" do
    visit artists_path
    expect(page).to have_content("Daft Punk")
  end

  it "shows the song count for each artist" do
    visit artists_path
    expect(page).to have_content("2 songs")
  end
end
