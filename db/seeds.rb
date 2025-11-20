# db/seeds.rb

require 'faker' # Explicitly require Faker for the seed task

puts "Cleaning database..."
Restaurant.destroy_all
Category.destroy_all

# --- 1. SEED CATEGORIES (Parent Records) ---
## Define the specific categories
CATEGORIES_DATA = [
  {
    name: "Chinese",
    description: "Diverse regional cuisines known for techniques like stir-frying and steaming."
  },
  {
    name: "Italian",
    description: "Features pasta, cheese, wine, and simple, fresh Mediterranean ingredients."
  },
  {
    name: "Japanese",
    description: "Emphasis on fresh, seasonal ingredients; includes sushi, ramen, and tempura."
  },
  {
    name: "French",
    description: "Known for rich sauces, formal presentation, and classic techniques."
  },
  {
    name: "Belgian",
    description: "Famous for frites, waffles, chocolate, and extensive craft beers."
  }
]

puts "Creating #{CATEGORIES_DATA.count} categories..."
categories = [] # Array to store created Category objects

CATEGORIES_DATA.each do |data|
  category = Category.create!(data)
  categories << category # Store the object for later linking
  puts "Created category: #{category.name}"
end

# --- 2. SEED RESTAURANTS (Child Records) ---
## We'll create 30 restaurants, 6 linked to each of the 5 categories.
puts "Creating 30 restaurants..."

30.times do |i|
  # Use the modulo operator (%) to cycle through the 5 category objects
  # This ensures an even distribution of 6 restaurants per category.
  category = categories[i % categories.length]

  # Build a unique restaurant name
  restaurant_name = [
    "The #{Faker::Hobby.activity.capitalize} #{category.name} Spot",
    "#{Faker::Name.first_name}'s #{category.name} Kitchen",
    "#{Faker::Company.industry.capitalize} #{category.name} Grill"
  ].sample

  # Create the restaurant record, linking it to a category object
  Restaurant.create!(
    name: restaurant_name,
    address: Faker::Address.street_address + ', ' + Faker::Address.city,
    phone_number: Faker::PhoneNumber.phone_number,
    # Assign the Category object directly (Rails automatically sets category_id)
    category: category
  )
  puts "Created restaurant #{i + 1}: #{restaurant_name} (Category: #{category.name})"
end

puts "--- Seeding Complete ---"
puts "Total Categories: #{Category.count}"
puts "Total Restaurants: #{Restaurant.count}"
