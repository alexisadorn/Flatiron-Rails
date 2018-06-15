require 'rails_helper'
require 'capybara/rspec'

describe "the recipe form", :type => :feature do
  it "sets the title" do
    visit '/recipes/new'
    fill_in :recipe_title, with: 'Chocolate Cake'
    find('input[name="commit"]').click
    expect(Recipe.last.title).to eq 'Chocolate Cake'
  end

  it "adds ingredients" do
    visit '/recipes/new'
    fill_in :recipe_ingredients_attributes_0_quantity, with: '1 cup'
    fill_in :recipe_ingredients_attributes_0_name, with: 'sugar'
    fill_in :recipe_ingredients_attributes_1_quantity, with: '1 tablespoon'
    fill_in :recipe_ingredients_attributes_1_name, with: 'vanilla'
    find('input[name="commit"]').click
    expect(Recipe.last.ingredients.map(&:quantity)).to eq ['1 cup', '1 tablespoon']
    expect(Recipe.last.ingredients.map(&:name)).to eq ['sugar', 'vanilla']
  end
end
