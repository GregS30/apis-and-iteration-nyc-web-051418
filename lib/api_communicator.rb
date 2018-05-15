require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  film_urls = get_film_urls(character_hash, character)

  puts film_urls

  parse_films(film_urls)

end


def parse_films(film_urls)
  film_urls.collect do |url|
    all_films = RestClient.get(url)
    JSON.parse(all_films)
  end
end

def get_film_urls(character_hash, character)

  character_hash["results"].map do |items|
    if items["name"] == character
      return items["films"]
    end
  end
end



  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list


end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
