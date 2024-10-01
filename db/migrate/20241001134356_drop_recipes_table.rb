class DropRecipesTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :recipes
  end
end
