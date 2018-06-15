class AddRecipeIdToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :recipe_id, :integer
  end
end
