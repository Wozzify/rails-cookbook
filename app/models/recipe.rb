class Recipe < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :categories, through: :bookmarks
end
