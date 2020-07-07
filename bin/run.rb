require_relative '../config/environment'

puts 'Welcome to Tasty Recipe App!'

puts  <<PARAGRAPH
Start by creating an account if this is your first time here:


Use your username if you are a returning user:


For list of available commands type: tasty_help
PARAGRAPH



def tasty_help 
    puts "Here are the list of commands:\n"
    puts "newUser              # create new user"
    puts "login('username')        # username"

    

end

def newUser
    puts "Please enter your first name: "
    first = gets.chomp
    puts "Please enter your last name: "
    last = gets.chomp
    puts "Please enter your date of birth (yyyy-mm-dd): "
    dob = gets.chomp
    puts "Input a unique username: "
    username = gets.chomp
    puts "Input a password (requ): "
    puts "What is your favorite food? "
    fav = gets.chomp

    User.create(f_name: first, l_name: last, username: username, dob: dob, f_food: fav)
    
end