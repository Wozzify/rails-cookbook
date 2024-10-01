require 'net/http'
require 'json'

class FetchRandomMealService
  def self.call
    url = URI("https://www.themealdb.com/api/json/v1/1/random.php")
    response = Net::HTTP.get(url)
    parsed_response = JSON.parse(response)

    meal_name = parsed_response.dig("meals", 0, "strMeal")
    meal_thumb = parsed_response.dig("meals", 0, "strMealThumb")
    meal_area = parsed_response.dig("meals", 0, "strArea")

    puts "Meal Name: #{meal_name}"
    puts "Meal Thumbnail: #{meal_thumb}"
    puts "Meal Area: #{meal_area}"

    { meal_name: meal_name, meal_thumb: meal_thumb, meal_area: meal_area }
  end
end
