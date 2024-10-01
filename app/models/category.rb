class Category < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :recipes, through: :bookmarks

  # Validations
  validates :name, presence: true, uniqueness: true
end
