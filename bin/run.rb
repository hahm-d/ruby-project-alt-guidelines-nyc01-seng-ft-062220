require_relative '../config/environment'

title

puts Rainbow("Welcome to ").green + Rainbow("Tasty Recipe App!").blue.bright.bg(:white)
puts Rainbow("Start by creating an account if this is your first time here.").green.bright
puts Rainbow("For returning users: login").green.bright
puts Rainbow("For list of available commands type: tasty").green.bright



def tasty_help
    puts `clear`
    puts Rainbow("****************************************************************").blue
    puts Rainbow("Here are the list of commands:\n").cyan
    puts Rainbow("register").yellow + "           # create new user" 
    puts Rainbow("login").yellow + "              # login with username"
    puts Rainbow("exit").yellow + "               # quit application"
    puts Rainbow("****************************************************************").blue
    puts Rainbow("After log-in, User options:\n").cyan 
    puts Rainbow("Search by Recipe name or recipe id").magenta  
    puts Rainbow("Add recipe to favorites").magenta         
    puts Rainbow("View/delete favorite Recipe list").magenta 
    puts Rainbow("View/delete search history").magenta 
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
    prompt = TTY::Prompt.new
    user = prompt.ask('What is your username?')
    pass = prompt.mask("What is your secret sauce? (password)")

    #database method to check if your exists
    userid = User.validmember(user, pass)
    if userid.is_a? Numeric
        puts
        puts Rainbow("Welcome back #{user}!").white.bg(:blue)
        puts
        usermenu(userid)
    else
        puts Rainbow("invalid log-in.").red.bright
    end
end


prompt = TTY::Prompt.new
choices = [
    {name: 'login', value: 1},
    {name: 'register', value: 2},
    {name: 'tasty options', value: 3},
    {name: 'exit', value: 4}
    ]
while pick = prompt.select("Select your pick?", choices)
    case pick
    when 1
        login_user
    when 2
        new_user
    when 3
        tasty_help
    when 4
        puts `clear`
        puts Rainbow("Time for dishes! See you again!").white.bg(:blue)
        exit
    end
end