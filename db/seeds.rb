
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Recipe.destroy_all

15.times do
  result = FetchRandomMealService.call
  Recipe.create(
    name: result[:meal_name],
    description: result[:meal_area],
    image_url: result[:meal_thumb],
    rating: rand(1..10) # Random rating between 1 and 10
  )
end
