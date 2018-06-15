require 'rails_helper'

RSpec.describe Preference, type: :model do
  it "has the right fields" do
    p = Preference.new(artist_sort_order: "DESC", song_sort_order: "ASC", allow_create_artists: false, allow_create_songs: true)
    expect(p.artist_sort_order.class).to eq String
    expect(p.song_sort_order.class).to eq String
    expect(p.allow_create_artists).to eq false
    expect(p.allow_create_songs).to eq true
  end
end
