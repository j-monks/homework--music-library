require("pry-byebug")
require_relative("models/artist")
require_relative("models/album")

Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
    "name" => "Johnny Cash"
})
artist1.save()

album1 = Album.new({ 
    "title" => "Orange Blossom Special",
    "genre" => "Rock",
    "artist_id" => artist1.id
    })
album1.save()

binding.pry
nil