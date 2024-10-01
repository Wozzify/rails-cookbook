class Bookmark < ApplicationRecord
  belongs_to :recipe
  belongs_to :category

  # Validations
  validates :comment, length: { minimum: 6 }
  validates :recipe_id, uniqueness: { scope: :category_id, message: 'This recipe is already in the category' }
end
