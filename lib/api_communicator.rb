require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)
  # films_arr.map { |ele| get_response_hash(ele) }
  # films_arr_string = response_hash["results"].first["films"]
  # response_film_hash = films_arr_string.map do |ele|
  #     response = RestClient.get(ele)
  #     JSON.parse(response)
  # end

  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_data = character_hash["results"].find { |data| data["name"] == character }
  film_urls = character_data["films"]
  film_data = film_urls.collect { |data| JSON.parse(RestClient.get(data)) }
  film_data

end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  # films_hash = get_character_movies_from_api("Luke Skywalker")
  films_hash.each.with_index(1) do |data, index|
    puts "#{index} " + data['title']
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
  # binding.pry
end

# def films_arr(name)
#   response_hash["results"].select { |ele| ele["name"] == name }
# end

# def response_hash
#   string = RestClient.get('http://www.swapi.co/api/people/')
#   hash = JSON.parse(string)
# end

# def get_response_hash(ele)
#   response = RestClient.get(ele)
#   JSON.parse(response)
# end


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each { |ele| puts ele["title"] }
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

