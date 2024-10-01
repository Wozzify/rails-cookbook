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
Category.destroy_all

300.times do
  begin
    result = FetchRandomMealService.call
    category = Category.find_or_create_by(name: result[:meal_area])
    Recipe.find_or_create_by(
      name: result[:meal_name],
      category_id: category.id
    ) do |recipe|
      recipe.image_url = result[:meal_thumb]
      recipe.rating = rand(6..10)
    end
  rescue JSON::ParserError => e
    puts "Error parsing JSON: #{e.message}"
  end

  # Introduce a delay to avoid hitting the rate limit
  sleep(0.3) # Adjust the sleep duration as needed
end
