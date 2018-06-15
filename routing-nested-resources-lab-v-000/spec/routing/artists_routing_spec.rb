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

  it 'only routes to index and show for songs' do
    base_route = "/artists/1/songs"
    expect(get: base_route + "/new").not_to route_to("songs#new")
    expect(get: base_route + "/1/edit").not_to be_routable
  end
end
