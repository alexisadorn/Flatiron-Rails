require 'rails_helper'

RSpec.describe "artists routing", type: :routing do

  before do
    Song.destroy_all
    Artist.destroy_all
  end

  it "routes to songs as a nested resource of artist" do
    expect(get: artist_songs_path(1)).to route_to("songs#index", artist_id: "1")
  end

  it "routes to a song as a nested resource of an artist" do
    expect(get: artist_song_path(1, 2)).to route_to("songs#show", artist_id: "1", id: "2")
  end

  it "routes to new song as a nested resource of an artist" do
    expect(get: new_artist_song_path(1)).to route_to("songs#new", artist_id: "1")
  end

  it "routes to edit song as a nested resource of an artist" do
    expect(get: edit_artist_song_path(1,2)).to route_to("songs#edit", artist_id: "1", id: "2")
  end
end
