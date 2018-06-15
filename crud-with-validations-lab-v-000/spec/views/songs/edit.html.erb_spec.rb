require 'rails_helper'

RSpec.describe "songs/edit", type: :feature do
  let(:song_attributes) do
    {
      title: "Rhythms Which I Played",
      release_year: 2000,
      released: true,
      genre: "Normcore",
      artist_name: "Man With Instruments"
    }
  end

  let(:song) { Song.create!(song_attributes) }

  it "renders the edit song form" do
    visit edit_song_path(song)

    form = find("form")

    expect(form[:action]).to eq(song_path(song))
    expect(form.find('input#song_title').value).to eq(song.title)
    expect(form.find('input#song_release_year').value).to eq(song.release_year.to_s)
    expect(form.find('input#song_released')).to be_checked
    expect(form.find('input#song_genre').value).to eq(song.genre)
    expect(form.find('input#song_artist_name').value).to eq(song.artist_name)
  end
end
