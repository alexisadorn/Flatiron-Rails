require 'spec_helper'

describe "creating recipes" do
  context "on the new recipe page" do

    # Is there a form with the given HTML ID?
    it "should have a form to create the recipes" do
      visit new_recipe_path

      expect(page).to have_css("form#new_recipe")
    end

    # Does the recipe get created when the form is submitted?
    # Is the user redirected to a page that displays the recipe name?
    it "should create a recipe when the form is submitted" do
      visit new_recipe_path

      fill_in 'recipe_name', with: 'Blueberry Pancakes'
      click_button('Create Recipe')

      expect(Recipe.first.name).to eq("Blueberry Pancakes")
      expect(page).to have_content("Blueberry Pancakes")
    end

    # Are there all ingredients listed in the form with
    # the ingredient name as a label and an associated checkbox?
    it "should display all the existing ingredients" do
      Ingredient.create(name: 'Paprika')
      Ingredient.create(name: 'Clove')
      Ingredient.create(name: 'Ginger')
      Ingredient.create(name: 'Cider')

      visit new_recipe_path

      expect(page).to have_css("input[type=\"checkbox\"]", :count => 4)

      expect(page).to have_content('Paprika')
      expect(page).to have_content('Clove')
      expect(page).to have_content('Ginger')
      expect(page).to have_content('Cider')
    end

    # Does the recipe get successfully created with 1 ingredient?
    # HINT: You need to use checkboxes. Each checkbox should have a CORRECTLY
    #       implemented HTML label
    #       (i.e. clicking on the <label> checks/unchecks the box).
    it "should create a recipe with one ingredient" do
      Ingredient.create(name: 'Spam')

      visit new_recipe_path

      fill_in 'recipe_name', with: 'Spam Cakes'

      check('Spam')
      click_button('Create Recipe')

      expect(Recipe.first.ingredients.where(name: 'Spam').count).to eq(1)
    end


    # Does the recipe get successfully created with many ingredients?
    # HINT: You need to use checkboxes. Each checkbox should have a CORRECTLY
    #       implemented HTML label
    #       (i.e. clicking on the <label> checks/unchecks the box).
    it "should create a recipe with many ingredients" do
      Ingredient.create(name: 'Paprika')
      Ingredient.create(name: 'Clove')
      Ingredient.create(name: 'Ginger')
      Ingredient.create(name: 'Cider')

      visit new_recipe_path

      fill_in 'recipe_name', with: 'Holiday Spice Cider'

      check('Paprika')
      check('Clove')
      check('Ginger')
      check('Cider')

      click_button('Create Recipe')

      expect(Recipe.first.ingredients.count).to eq(4)
    end


    # Does the recipe get successfully created with 0 ingredients?
    # HINT: You need to use checkboxes. Each checkbox should have a CORRECTLY
    #       implemented HTML label
    #       (i.e. clicking on the <label> checks/unchecks the box).
    it "should create a recipe with 0 ingredients" do
      Ingredient.create(name: 'Paprika')
      Ingredient.create(name: 'Clove')

      visit new_recipe_path

      fill_in 'recipe_name', with: 'Recipe in Progress'

      click_button('Create Recipe')

      expect(Recipe.first.ingredients.count).to eq(0)
    end
  end
end
