def user_helper
puts  <<PARAGRAPH
        
    Main Menu
    List of commands: Search, Favorites, History
    
    use any of the methods above!
****************************************************************  

PARAGRAPH

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
                recipeDetail(user_input2)
            elsif user_input2 == 'n' || user_input2 == 'no'
                puts "search Tasty recipes by name: "
                user_input2 = gets.chomp.downcase
                # API call happens (finds list of recipes)
                searchForRecipe(user_input2)
                SearchHistory.create(s_text: user_input2, user_id: userid)
            end

        when 'favorites' # user can delete / view favorite recipes   
            fav = DishSearch.user_like(userid)
            if fav.blank?
                puts `clear`
                puts "Your favorite's list is empty"
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
                    puts "removed! type: Favorites to see updated list"
                else
                    user_helper
                end
            end

        when 'history'  # user delete or view search history
            hist = SearchHistory.user_history(userid)
            puts "Here is your search history: #{hist}"
            puts
            puts "Delete history? [y/n]"
            user_input2 = gets.chomp.downcase

            if user_input2 == 'y'
                SearchHistory.clear_history(userid)
                puts "Search history deleted! "
            end
            user_helper

        when 'exit'
            puts `clear`
            puts "Good Bye! See you again!"
            puts
            break

        else 
            puts `clear`
            puts "Invalid response. Please try again."
            puts
            puts "Main menu: Search, Favorites, History"
            puts "use any of the methods above"
        end

    end

end