require 'uri'
require 'net/http'
require 'openssl'
require 'httparty'
require 'dotenv'
require 'pry'

Dotenv.load


#response test 
def valid_http?
   response = HTTParty.get('https://tasty.p.rapidapi.com')
   response.code 
end


#get recipes/detail
def RecipeDetail(recipe_id)
    url = URI("https://tasty.p.rapidapi.com/recipes/detail?id=#{recipe_id}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'tasty.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV['APIKEY']

    response = http.request(request)
    puts response.read_body

    binding.pry
end



#get recipes/list  *MAIN function
def SearchForRecipe(word) #word is "cheesecake or apple pie"
    #condition for more than one word 
    words_array = word.strip.split(" ")

   if words_array.length == 1  
    url = URI("https://tasty.p.rapidapi.com/recipes/list?q=#{words_array[0]}&from=0&sizes=10")
   elsif words_array.length == 2
    url = URI("https://tasty.p.rapidapi.com/recipes/list?q=#{words_array[0]}%20#{words_array[1]}&from=0&sizes=10")
   else
    return "Please limit your search to 1 or 2 words"
    #prompt user input 
   end

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'tasty.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV['APIKEY']

    response = http.request(request)
    puts response.read_body

end