class AddIngredientsToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :ingredients, :text
  end
end
