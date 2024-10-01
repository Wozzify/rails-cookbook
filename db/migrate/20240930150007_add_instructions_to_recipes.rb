class AddInstructionsToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :instructions, :text
  end
end
