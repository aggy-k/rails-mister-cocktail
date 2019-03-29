require 'open-uri'
require 'json'

puts "Deleting all records of ingredients..."
Ingredient.destroy_all if Rails.env.development?

puts "Seeding ingredients..."

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
file = open(url).read
parsed = JSON.parse(file)

parsed["drinks"].each do |i|
  Ingredient.create!(name: i["strIngredient1"])
end

puts "Created #{Ingredient.count} ingredient(s)"


puts "Deleting all records of cocktails..."
Cocktail.destroy_all if Rails.env.development?

puts "Seeding cocktails..."

url_c = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
file_c = open(url_c).read
parsed_c = JSON.parse(file_c)

parsed_c["drinks"].first(20).each do |i|
  c = Cocktail.create!(name: i["strDrink"])
  c.remote_image_url = i["strDrinkThumb"]
  c.save
end

puts "Created #{Cocktail.count} cocktail(s)"


puts "Converted images as remote url"
