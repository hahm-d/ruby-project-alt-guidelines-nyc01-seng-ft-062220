require_relative '../config/environment'

#def greet
#    puts 'Welcome to Felp, the best resource for restaurant information in the world!'
#end
#cli = CommandLineInterface.new

#cli.greet

puts "
    ______)              _____                     _____          
  (, /                 (, /   )        ,         (, /  |         
    /   _   _  _/_       /__ /  _  _    __    _    /---| __  __  
 ) /   (_(_/_)_(__(_/_) /   \__(/_(___(_/_)__(/_) /    |_/_)_/_)_
(_/              .-/ (_/             .-/       (_/    .-/ .-/    
                (_/                 (_/              (_/ (_/     

"


#Greeting message - Tasty App
puts  <<PARAGRAPH

Welcome! 
Start by creating an account if this is your first time here
type: new user
For returning user
type: login
For list of available commands type: tasty

PARAGRAPH



def tasty_help
    puts `clear`
    puts "Here are the list of commands:\n"
    puts "new user             # create new user"
    puts "login                # login with username"
    puts "exit                 #quit application"
    puts
end

def valid_dob(dob)
    if dob.match('^(\d\d\d\d)(\d\d)(\d\d)$')
       return true
    else
       return false 
    end
end

def new_user
    puts `clear`
    puts "Please enter your first name: "
    first = gets.chomp
    puts "Please enter your last name: "
    last = gets.chomp
    puts "Please enter your date of birth (yyyymmdd): "
    check = false
    while check == false do
        dob = gets.chomp
        check = valid_dob(dob)
        if check == true
            break
        end
        puts "Please enter a valid date of birth (yyyymmdd):"
    end

    puts "Input a unique username: "
    username = gets.chomp
    puts "Input a password: "
    userpass = gets.chomp 
    puts "What is your favorite food? "
    fav = gets.chomp

    User.create(f_name: first, l_name: last, username: username, dob: dob, f_food: fav)
    userid = User.validmember(username, userpass)
    usermenu(userid) 
end


def login_user
    puts `clear`
    puts "Input username: "    
    user = gets.chomp
    puts "Input password: "
    pass = gets.chomp 

    #database method to check if your exists
    userid = User.validmember(user, pass)
    if userid.is_a? Numeric
        puts
        puts "Welcome back #{user}!"
        usermenu(userid)
    else
        puts "invalid log-in."
    end
end


while user_input = gets.chomp
    case user_input
    when 'tasty' 
        tasty_help
    when 'new user'
        new_user
    when 'login'
        login_user
        break
    when 'exit'
        puts `clear`
        puts "Time for dishes! See you again!"
        puts
        break
    else 
        puts `clear`
        puts "Invalid response. Please try again."
        puts "Type tasty for available options."
    end
end
