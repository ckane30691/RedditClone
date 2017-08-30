# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 50.times do
#   User.create!(username: Faker::Internet.user_name, password: "password")
# end
50.times do
  Sub.create!(title: Faker::Cat.registry, description: Faker::Movie.quote, moderator: User.all[rand(50)])
end
