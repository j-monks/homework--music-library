require("pry-byebug")
require_relative("models/artist")
require_relative("models/album")

Album.delete_all()
Artist.delete_all()

# ARTISTS
artist1 = Artist.new({
    "name" => "Johnny Cash"
})
artist1.save()

artist2 = Artist.new({
    "name" => "alt-J"
})
artist2.save()

# ALBUMS
album1 = Album.new({ 
    "title" => "Orange Blossom Special",
    "genre" => "Rock",
    "artist_id" => artist1.id
})
album1.save()

album2 = Album.new({
    "title" => "Reduxer",
    "genre" => "Alternative/Indie",
    "artist_id" => artist2.id
})
album2.save()

album1.delete()

binding.pry
nil