require 'rails_helper'

RSpec.describe "posts/edit", type: :feature do
  it 'shows an update form that submits content, redirects, and shows the updated content' do
    visit edit_post_path(@post)

    fill_in 'post[title]', with: "My Edited Post"
    fill_in 'post[description]', with: "My edited post description"

    click_on "Update Post"

    expect(current_path).to eq(post_path(@post))
    expect(page).to have_content("My Edited Post")
    expect(page).to have_content("My edited post description")
  end
end
