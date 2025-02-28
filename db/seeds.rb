# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'
require 'faker'

puts "destroying seed data"
Bookmark.destroy_all
Movie.destroy_all
puts "destroyed seed data"


# List.create(name: "Top Rated Movies")
# List.create(name: "Actions Movies")
# List.create(name: "Fantasy Movies")

url = "https://tmdb.lewagon.com/movie/top_rated"
# puts url

url_serialized = URI.open(url).read
# puts url_serialized

movies = JSON.parse(url_serialized)
results = movies["results"]
# puts movies

# puts results[0]["title"]

10.times do |t|
  Movie.create(
      title: results[t]["title"],
      overview: results[t]["overview"],
      poster_url: "https://image.tmdb.org/t/p/original#{results[t]["poster_path"]}",
      rating: results[t]["vote_average"]
  )
end


# require 'open-uri'
# require 'json'

# # L'URL de l'API TMDb via le proxy
# url = "https://tmdb.lewagon.com/movie/top_rated"

# # Faire la requête et récupérer les données
# response = URI.open(url).read
# data = JSON.parse(response)

# # Pour chaque film dans la réponse, on va créer un enregistrement dans la base de données
# data['results'].first(10).each do |movie| # Limite aux 10 premiers films
#   title = movie['title']
#   overview = movie['overview']
#   poster_url = "https://image.tmdb.org/t/p/original#{movie['poster_path']}" # URL de l'image
#   rating = movie['vote_average']

#   # Création du film dans la base de données
#   Movie.create(
#     title: title,
#     overview: overview,
#     poster_url: poster_url,
#     rating: rating
#   )
# end
