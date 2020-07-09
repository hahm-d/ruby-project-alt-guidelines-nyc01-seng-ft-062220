
def user_helper
    puts Rainbow("****************************************************************").blue 
    puts "                          " + Rainbow("Main Menu").white.bright.bg(:blue)
    puts Rainbow("List of commands:").green.bright
    puts Rainbow("  Search ").yellow.bright
    puts Rainbow("    Favorites ").yellow.bright
    puts Rainbow("        History ").yellow.bright

    puts Rainbow("Type any of the commands above!").green.bright
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
            prompt = TTY::Prompt.new 
            userchoice = prompt.select("would you like to search by recipe id?", %w(Yes No))
            if userchoice == "Yes"
                puts "enter id: "
                user_input2 = gets.chomp.downcase
                #API call using input 
                validation = recipeDetail(user_input2)
                if validation == "Found!"
                    view_recipe(userid, user_input2)
                end
            else userchoice == "No"
                puts "search Tasty recipes by name: "
                user_input2 = gets.chomp.downcase
                # API call happens (finds list of recipes)
                validation = searchForRecipe(user_input2)
                SearchHistory.create(s_text: user_input2, user_id: userid)
            end

        when 'favorites' # user can delete / view favorite recipes   
            fav = DishSearch.user_like(userid)
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
                    user_helper
                else
                    user_helper
                end

        when 'history'  # user delete or view search history
            hist = SearchHistory.user_history(userid)
            if hist.any? 
                puts "Here is your search history: #{hist}"
                puts
                prompt = TTY::Prompt.new 
                userchoice = prompt.select("Delete history?", %w(Yes No))
                if userchoice == "Yes"
                    SearchHistory.clear_history(userid)
                    puts Rainbow("Search history deleted!").blue.bright.bg(:white)
                end
            else
                puts Rainbow("No search history available.").black.bg(:white)
                puts 
            end
            user_helper

        when 'exit'
            puts `clear`
            puts Rainbow("Good Bye! See you again!").black.bg(:white)
            exit

        else 
            puts `clear` 
            user_helper
        end

    end

end