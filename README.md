Module One Final Project

Tasty Recipe App
========================
User Story: 

who?  
For non-professional individuals who want to try new recipes

what?  
Tasty cooking app. For sharing the most tasty recipes

why?  
Share experience, options about recipe.
---
User Experience: 

1.  Users can search for Recipes and return a list to select from.
2.  Users can also favorite a recipe they have selected, also remove favorites from personal list (User_favorite).
3.  App stores user search history, Users can view/delete search history. 
4.  Users can also like a recipe. 
    bonus: Users can share recipes with other users.

What does your schema look like? 

- table: User

    f_name

    l_name

    dateofbirth

    favoritefood

    username 

- table: UserFavorite

    user_id (f)

    recipe_id (f)

    recipe_name

- table: UserSearchHistory

    search_text

    user_id (f)

- table: Dish

    user_id (f) 

    recipe_id (f)

    total_likes

- table: Recipe

    ???




Tasty API link 

API: [https://rapidapi.com/apidojo/api/tasty?endpoint=apiendpoint_96b832dc-ba57-4017-b930-9b129a633829](https://rapidapi.com/apidojo/api/tasty?endpoint=apiendpoint_96b832dc-ba57-4017-b930-9b129a633829)
