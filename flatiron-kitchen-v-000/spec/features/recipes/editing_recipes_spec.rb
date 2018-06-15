require 'spec_helper'

describe "editing recipes" do
  context "on the edit recipe page" do
    before do
      @recipe = Recipe.create(name: "Rice Pudding")
      visit edit_recipe_path(@recipe)
    end

    # Is there a form with the given HTML id?
    it "should have a form to edit the recipe" do
      expect(page).to have_css("form#edit_recipe_#{@recipe.id}")
    end

    # Does the form correctly update the recipe name?
    it "should update a recipe when the form is submitted" do
      fill_in 'recipe_name', with: "Rice Pudding with Farmer Darryl's Frog Sauce"
      click_button('Update Recipe')

      expect(Recipe.first.name).to eq("Rice Pudding with Farmer Darryl's Frog Sauce")
      expect(page).to have_content("Rice Pudding with Farmer Darryl's Frog Sauce")
    end

    # Are there all ingredients listed in the form with
    # the ingredient name as a label and an associated checkbox?
    it "should display all the existing ingredients" do
      Ingredient.create(name: 'Paprika')
      Ingredient.create(name: 'Clove')
      Ingredient.create(name: 'Ginger')
      Ingredient.create(name: 'Cider')

      visit edit_recipe_path(@recipe)

      expect(page).to have_css("input[type=\"checkbox\"]", :count => 4)

      expect(page).to have_content('Paprika')
      expect(page).to have_content('Clove')
      expect(page).to have_content('Ginger')
      expect(page).to have_content('Cider')
    end

    # Are all the ingredients added to the recipe?
    # HINT: You need to use checkboxes. Each checkbox should have a CORRECTLY
    #       implemented HTML label
    #       (i.e. clicking on the <label> checks/unchecks the box).
    it "should be able to add ingredients" do
      Ingredient.create(name: 'Paprika')
      Ingredient.create(name: 'Clove')
      Ingredient.create(name: 'Ginger')
      Ingredient.create(name: 'Cider')

      visit edit_recipe_path(@recipe)

      check('Paprika')
      check('Clove')
      check('Ginger')
      check('Cider')

      click_button('Update Recipe')

      expect(@recipe.ingredients.count).to eq(4)
    end


    # Are all the ingredients removed from the recipe?
    # HINT: You need to use checkboxes. Each checkbox should have a CORRECTLY
    #       implemented HTML label
    #       (i.e. clicking on the <label> checks/unchecks the box).
    it "should be able to remove ingredients" do
      @recipe.ingredients.create(name: 'Paprika')
      @recipe.ingredients.create(name: 'Clove')
      @recipe.ingredients.create(name: 'Ginger')
      @recipe.ingredients.create(name: 'Cider')

      expect(@recipe.ingredients.count).to eq(4)

      visit edit_recipe_path(@recipe)

      uncheck('Paprika')
      uncheck('Clove')
      uncheck('Ginger')
      uncheck('Cider')

      click_button('Update Recipe')

      expect(@recipe.ingredients.count).to eq(0)
    end
  end
end
