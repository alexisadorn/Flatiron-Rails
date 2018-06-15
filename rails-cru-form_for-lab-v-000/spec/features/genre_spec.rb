require 'rails_helper'

describe 'navigate' do
  before do
    @genre = Genre.create(name: "My Genre")
  end

  it 'shows the name on the show page in a h1 tag' do
    visit "/genres/#{@genre.id}"
    expect(page).to have_css("h1", text: "My Genre")
  end

  it 'to genre pages' do
    visit "/genres/#{@genre.id}"
    expect(page.status_code).to eq(200)
  end
end

describe 'form' do
  it 'shows a new form that submits content and redirects and prints out params' do
    visit new_genre_path

    fill_in 'genre[name]', with: "My genre name"

    click_on "Create Genre"

    expect(page).to have_content("My genre name")
  end

  it 'shows an edit form that submits content and redirects and prints out params' do
    @genre = Genre.create(name: "My Genre")

    visit edit_genre_path(@genre)

    fill_in 'genre[name]', with: "My edit"

    click_on "Update Genre"

    expect(page).to have_content("My edit")
  end
end
