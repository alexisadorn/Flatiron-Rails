require 'rails_helper'

RSpec.describe ArtistsHelper, type: :helper do

  before do
    Artist.destroy_all
    Song.destroy_all
    @artist = Artist.create!(name: "Daft Punk")
    @song = @artist.songs.create!(title: "The Grid")
  end

  subject { helper }

  it { should respond_to(:display_artist).with(1).argument }

  it "displays a link to edit the song if artist empty" do
    song = Song.create(title: "Bohemian Rhapsody")
    expect(helper.display_artist(song)).to include(edit_song_path(song))
    expect(helper.display_artist(song)).to include("Add Artist")
  end

  it "displays a link to the artist page if artist not empty" do
    expect(helper.display_artist(@song)).to include(artist_path(@artist))
    expect(helper.display_artist(@song)).to include(@artist.name)
  end
end
