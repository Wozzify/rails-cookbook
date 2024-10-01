class BookmarksController < ApplicationController
  before_action :set_category

  def new
    @bookmark = Bookmark.new
    @recipes = Recipe.where.not(id: @category.bookmarks.pluck(:recipe_id)).order(:name)
  end

  def create
    @bookmark = @category.bookmarks.new(bookmark_params)

    if @bookmark.save
      redirect_to category_path(@category)
    else
      @recipes = Recipe.where.not(id: @category.bookmarks.pluck(:recipe_id)).order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to category_path(@category), status: :see_other
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      redirect_to category_path(@category), notice: 'Bookmark updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :recipe_id)
  end
end
