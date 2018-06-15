require 'rails_helper'

RSpec.describe "categories/show", type: :feature do
  it 'shows the category name on the show page in an <h1> tag' do
    visit category_path(@category)
    expect(page).to have_css("h1", text: "My Category")
  end

  it "contains links to the category's posts" do
    visit category_path(@category)
    expect(page).to have_link(@post.title, href: post_path(@post))
  end
end
