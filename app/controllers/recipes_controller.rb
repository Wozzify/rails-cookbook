class RecipesController < ApplicationController
  def new
    @category = Category.find(params[:category_id])
    @recipe = @category.recipes.build
  end

  def create
    @category = Category.find(params[:category_id])
    @recipe = @category.recipes.build(recipe_params)
    if @recipe.save
      redirect_to category_path(@category), notice: 'Recipe was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @category = @recipe.category
    @recipe.destroy
    redirect_to category_path(@category), notice: 'Recipe was successfully removed.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :ingredients, :instructions)
  end
end
