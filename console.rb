require("pry-byebug")
require_relative("models/artist")

Artist.delete_all()

artist1 = Artist.new({
    "name" => "Johnny Cash"
})
artist1.save()








binding.pry
nil