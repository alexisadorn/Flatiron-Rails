require 'rails_helper'

RSpec.describe 'songs/show' do
  before do
    Artist.destroy_all
    Song.destroy_all
    @song = Song.create(title: "Bullet the Blue Sky", artist_name: "U2")
    allow(view).to receive(:display_artist).and_return("They Might Be Giants")
    assign(:song, Song.first)
  end

  it 'calls the helper to display the artist' do
    render
    expect(rendered).to match /They Might Be Giants/
  end
end

