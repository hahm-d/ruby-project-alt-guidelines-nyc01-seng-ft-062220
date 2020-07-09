require_relative '../config/environment'

puts Rainbow("
    ______)              _____                     _____          
(, /                 (, /   )        ,         (, /  |         
    /   _   _  _/_       /__ /  _  _    __    _    /---| __  __  
) /   (_(_/_)_(__(_/_) /   \__(/_(___(_/_)__(/_) /    |_/_)_/_)_
(_/              .-/ (_/             .-/       (_/    .-/ .-/    
                (_/                 (_/              (_/ (_/     

").blue.bright


#Greeting message - Tasty App

puts Rainbow("Welcome to ").green + Rainbow("Tasty Recipe App!").blue.bright.bg(:white)
puts Rainbow("Start by creating an account if this is your first time here:").green
puts Rainbow("new user").blue.bright
puts Rainbow("For returning users:").green
puts Rainbow("login").blue.bright
puts Rainbow("For list of available commands type: ").green
puts Rainbow("tasty").blue.bright



def tasty_help
    puts `clear`
    puts Rainbow("****************************************************************").blue
    puts Rainbow("Here are the list of commands:\n").cyan
    puts Rainbow("new user").yellow + "           # create new user" 
    puts Rainbow("login").green + "              # login with username"
    puts Rainbow("exit").magenta + "               # quit application"
    puts Rainbow("****************************************************************").blue
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
        puts Rainbow("Welcome back #{user}!").white.bg(:blue)
        usermenu(userid)
    else
        puts Rainbow("invalid log-in.").red.bright
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
        puts Rainbow("Time for dishes! See you again!").white.bg(:blue)
        puts
        break
    else 
        puts `clear`
        puts "Invalid response. Please try again."
        puts "Type tasty for available options."
    end
end