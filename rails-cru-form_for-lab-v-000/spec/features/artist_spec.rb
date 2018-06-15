require 'rails_helper'

describe 'navigate' do
  before do
    @artist = Artist.create(name: "My Artist", bio: "My artist bio")
  end

  it 'shows the name on the show page in a h1 tag' do
    visit "/artists/#{@artist.id}"
    expect(page).to have_css("h1", text: "My Artist")
  end

  it 'to artist pages' do
    visit "/artists/#{@artist.id}"
    expect(page.status_code).to eq(200)
  end

  it 'shows the bio on the show page in a p tag' do
    visit "/artists/#{@artist.id}"
    expect(page).to have_css("p", text: "My artist bio")
  end
end

describe 'form' do
  it 'shows a new form that submits content and redirects and prints out params' do
    visit new_artist_path

    fill_in 'artist[name]', with: "My artist name"
    fill_in 'artist[bio]', with: "My artist bio"

    click_on "Create Artist"

    expect(page).to have_content("My artist name")
  end

  it 'shows an edit form that submits content, redirects and prints out params' do
    @artist = Artist.create(name: "My Artist", bio: "My artist bio")

    visit edit_artist_path(@artist)

    fill_in 'artist[name]', with: "My edit"
    fill_in 'artist[bio]', with: "My artist bio"

    click_on "Update Artist"

    expect(page).to have_content("My edit")
  end
end
