require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  character_hash = response_hash["results"].find{|info| info["name"].downcase == character_name}
  character_movies_array = character_hash["films"]

  # collect those film API urls, make a web request to each URL to get the info
  #   for that film
  # character_movies_array.
  character_movies_array.map{|movie_url| JSON.parse(RestClient.get(movie_url))}
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each.with_index(1){|film, index| puts "#{index}. #{film["title"]}"}
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
