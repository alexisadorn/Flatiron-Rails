require 'rails_helper'

RSpec.describe "categories/edit", type: :feature do
  it 'shows an update form that submits content, redirects, and shows the updated content' do
    visit edit_category_path(@category)

    fill_in 'category[name]', with: "My Edited Category"

    click_on "Update Category"

    expect(current_path).to eq(category_path(@category))
    expect(page).to have_content("My Edited Category")
  end
end
