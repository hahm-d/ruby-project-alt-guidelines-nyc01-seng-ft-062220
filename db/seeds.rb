#clear existing seed data
User.destroy_all
SearchHistory.destroy_all
Favorite.destroy_all
Recipe.destroy_all
Dish.destroy_all

user1 = User.create(f_name: "Anthony", l_name: "Griffin", username: "LongBeach", dob: "1995-09-11", f_food: "Samoan food")
user2 = User.create(f_name: Faker::Name.first_name, l_name: Faker::Name.last_name, username: Faker::Twitter.screen_name, dob: Faker::Date.in_date_period, f_food: Faker::Food.dish)
user3 = User.create(f_name: Faker::Name.first_name, l_name: Faker::Name.last_name, username: Faker::Twitter.screen_name, dob: Faker::Date.in_date_period, f_food: Faker::Food.dish)

search1 = SearchHistory.create(s_text: Faker::Food.dish, user: user1)
search2 = SearchHistory.create(s_text: Faker::Food.fruits, user: user1)
search3 = SearchHistory.create(s_text: Faker::Food.dish, user: user1)
search4 = SearchHistory.create(s_text: Faker::Food.dish, user: user1)

fav1 = Favorite.create(tasty_remote_id: 6335, user: user1)
fav2 = Favorite.create(tasty_remote_id: 6337, user: user1)
fav3 = Favorite.create(tasty_remote_id: 6055, user: user1)
fav4 = Favorite.create(tasty_remote_id: 6126, user: user2)

recipe1 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 6335)
recipe2 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 6337)
recipe3 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 6055)
recipe4 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 6126)
recipe5 = Recipe.create(name: Faker::Food.dish, tasty_remote_id: 5806)

dish1 = Dish.create(recipe: recipe1, user: user1, user_like: 1)
dish2 = Dish.create(recipe: recipe2, user: user1, user_like: 1)
dish3 = Dish.create(recipe: recipe3, user: user1, user_like: nil)
dish4 = Dish.create(recipe: recipe4, user: user2, user_like: nil)
dish5 = Dish.create(recipe: recipe5, user: user2)

puts "/////////////////////////////////////////////// SUCCESS ///////////////////////////////////////////////"
puts "seed data successfully added!\n"
puts
puts "start app using: rake console\n"
puts
puts "type tasty_help for all available commands"
puts "//////////////////////////////////////////////// TASTY ////////////////////////////////////////////////"