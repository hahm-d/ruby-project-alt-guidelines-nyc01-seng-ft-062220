require 'rainbow'

def view_recipe(userid, recipe_remote_id)
    #find recipe instance 
    this_recipe = Recipe.find_by(tasty_remote_id: recipe_remote_id)
    puts `clear`
    puts Rainbow("****************************************************************").green.bright
    puts Rainbow("Recipe Name:").blue + "#{this_recipe.name}"
    puts Rainbow("Recipe Tasy ID:").blue + " #{recipe_remote_id}"
    puts Rainbow("Total Calories:").blue + " #{this_recipe.calories}"
    puts Rainbow("Total Est. Time:").blue + "#{this_recipe.total_time}"
    puts Rainbow("Number of Servings:").blue + "#{this_recipe.num_serving}"
    puts Rainbow("Recipe description:").blue + "#{this_recipe.description}"
    puts Rainbow("Related Keywords:").blue + " #{this_recipe.keywords}"
    puts Rainbow("****************************************************************").green.bright
    many_instructions = Instruction.find_by(recipe: this_recipe)
    puts 
    puts Rainbow("Instructions: #{many_instructions.step}").blue.bright
    #check if relationship already exists
    dup_check = DishSearch.where(recipe: this_recipe, user_id: userid).exists?
    if dup_check == false
    DishSearch.create(recipe: this_recipe, user_id: userid)
    end
    #prompt user if they want to favorite / like
end