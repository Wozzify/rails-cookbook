class BookmarksController < ApplicationController
  before_action :set_category

  def new
    @bookmark = Bookmark.new
    @recipes = Recipe.where.not(id: @category.bookmarks.select(:recipe_id)).order(:name)
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.category = @category
    @recipes = Recipe.where.not(id: @category.bookmarks.select(:recipe_id)).order(:name)

    if @bookmark.save
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to category_path(@category), status: :see_other
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :recipe_id)
  end
end
