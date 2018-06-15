require 'rails_helper'

RSpec.describe "posts/show", type: :feature do
  it "shows the post's title in an <h1> tag" do
    visit post_path(@post)
    expect(page).to have_css("h1", text: "My Post")
  end

  it "shows the post's description in a <p> tag" do
    visit post_path(@post)
    expect(page).to have_css("p", text: "My post desc")
  end

  it "contains a link to the post's category" do
    visit post_path(@post)
    expect(page).to have_link(@category.name, href: category_path(@category))
  end
end
