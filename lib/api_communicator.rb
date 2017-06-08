require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  # all_chars only contains page 1 now...
  all_data = []
  url = "http://www.swapi.co/api/people/?page=1"
  payload = JSON.parse(RestClient.get(url))
  
  while payload["next"]  
    payload = JSON.parse(RestClient.get(payload["next"]))
    all_data << payload["results"]
  end

  all_data = all_data.flatten
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  
  all_data.each_with_object({}) do |char_hash, char_film_hash|
    char_film_hash[character] = char_hash["films"] if char_hash["name"].downcase == character.downcase
  end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.values.flatten.each do |film|
    film_data = RestClient.get(film)
    films_hash = JSON.parse(film_data)
    puts ""
    puts "Movie Title:"
    puts "#{films_hash["title"]}" 
    puts "" 
    puts "Description: "
    puts ""
    puts "#{films_hash["opening_crawl"]}"
    puts "---------------"    
  end
end

def show_character_movies(character)

  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

get_character_movies_from_api("Chewbacca")


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
