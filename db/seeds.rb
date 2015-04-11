# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(full_name: "Michael McDevitt", email: "mmcdevi1@gmail.com", password: "koplop")

100.times do 
    User.create(
            full_name: Faker::Name.name,
            email: Faker::Internet.email,
            password: "koplop"
        )
end

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

Review.create(content: Faker::Lorem.paragraph(5), rating: 5, user_id: 1, video_id:10)
100.times do 
    Review.create(content: Faker::Lorem.paragraph(5), rating: rand(1..5), user_id: rand(1..80), video_id: rand(1..10))
end