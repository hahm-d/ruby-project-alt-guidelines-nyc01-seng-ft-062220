class User < ActiveRecord::Base
    has_many :search_histories
    has_many :favorites
    has_many :dishes
    has_many :recipes, through: :dishes


    #username must not already exist in database

    #

end