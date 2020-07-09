
def user_helper

    puts Rainbow("****************************************************************").blue 
    puts "                          " + Rainbow("Main Menu").white.bright.bg(:blue)
    puts Rainbow("List of commands:").green.bright
    puts Rainbow("  Search ").yellow.bright
    puts Rainbow("    Favorites ").yellow.bright
    puts Rainbow("        History ").yellow.bright

    puts Rainbow("use any of the methods above!").green.bright
    puts Rainbow("****************************************************************").blue 
end

def is_integer(string)
    string.to_i.to_s
end

def usermenu(userid)

user_helper

    while user_input = gets.chomp.downcase
        case user_input   # search
        when 'search' 
            puts "would you like to search by recipe id? [y/n] "
            user_input2 = gets.chomp.downcase

            if user_input2 == 'y' || user_input2 == 'yes'
                puts "enter id: "
                user_input2 = gets.chomp.downcase
                #API call using input 
                validation = recipeDetail(user_input2)
                if validation == "Found!"
                    view_recipe(userid, user_input2)
                end
            elsif user_input2 == 'n' || user_input2 == 'no'
                puts "search Tasty recipes by name: "
                user_input2 = gets.chomp.downcase
                # API call happens (finds list of recipes)
                validation = searchForRecipe(user_input2)
                SearchHistory.create(s_text: user_input2, user_id: userid)
            end

        when 'favorites' # user can delete / view favorite recipes   
            fav = DishSearch.user_like(userid)
            if fav.blank?
                puts `clear`
                puts Rainbow("Your favorite's list is empty").green
                user_helper
            else
                puts `clear`
                puts "Here are your favorites: "
                fav.each.with_index {|val, i| puts "number: #{i + 1}  #{val}" if val}
                puts 
                puts "Remove favorite from list? Select by order number"
                puts "or press any other key to exit favorites"
                user_input2 = gets.chomp.downcase 
                if is_integer(user_input2) && fav[user_input2.to_i - 1]
                    recipe_name = fav[user_input2.to_i - 1]
                    local_dish_id = DishSearch.user_dish(userid, recipe_name) 
                    DishSearch.destroy(local_dish_id)
                    puts Rainbow("removed! type: Favorites to see updated list").blue.bright.bg(:white)
                else
                    user_helper
                end
            end

        when 'history'  # user delete or view search history
            hist = SearchHistory.user_history(userid)
            puts "Here is your search history: #{hist}"
            puts
            puts Rainbow("Delete history? [y/n]").yellow
            user_input2 = gets.chomp.downcase

            if user_input2 == 'y'
                SearchHistory.clear_history(userid)
                puts Rainbow("Search history deleted!").blue.bright.bg(:white)
            end
            user_helper

        when 'exit'
            puts `clear`
            puts Rainbow("Good Bye! See you again!").black.bg(:white)
            puts
            break

        else 
            puts `clear` 
            user_helper
        end

    end

end