class AddCategoryToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_reference :recipes, :category, foreign_key: true
  end
end
