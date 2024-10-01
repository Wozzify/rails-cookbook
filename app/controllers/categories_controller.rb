class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.image_url = RANDOM_IMAGES.sample

    if @category.save
      redirect_to category_path(@category), notice: "Category was successfully created."
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @recipes = Recipe.where(category_id: @category.id)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to category_path(@category), notice: "Category was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, status: :see_other
  end

  # For handling bookmark comment edits
  def edit_comment
    @category = Category.find(params[:category_id])
    @recipe = Recipe.find(params[:recipe_id])
    @bookmark = Bookmark.find(params[:id]) # Find bookmark by ID
  end

  def update_comment
    @category = Category.find(params[:category_id])
    @recipe = Recipe.find(params[:recipe_id])
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      redirect_to category_path(@category), notice: "Comment updated successfully."
    else
      render :edit_comment
    end
  end

  private

  RANDOM_IMAGES = [
    "https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?q=80&w=1975&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1432457990754-c8b5f21448de?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1512149177596-f817c7ef5d4c?q=80&w=1900&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1444731961956-751ed90465a5?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://plus.unsplash.com/premium_photo-1673580742890-4af144293960?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  ]

  def category_params
    params.require(:category).permit(:name)
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :recipe_id)
  end
end
