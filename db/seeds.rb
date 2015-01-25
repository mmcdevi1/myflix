# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do 
  Video.create(title: "Family Guy", 
             description: "Family guy volume 2", 
             small_cover_url: "tmp/family_guy.jpg", 
             large_cover_url: "tmp/monk_large.jpg",
             category_id: 1
            )
end
10.times do 
  Video.create(title: "Monk", 
             description: "Family guy volume 2", 
             small_cover_url: "tmp/monk.jpg", 
             large_cover_url: "tmp/monk_large.jpg",
             category_id: 4
            )
end

Category.create(name: "Comedy")
Category.create(name: "Horror")
Category.create(name: "Documentary")
Category.create(name: "Foreign")
