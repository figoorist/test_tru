# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


ips = []

# айпишников использовать штук 50 разных
50.times do
  ips.push Faker::Internet.ip_v4_address
end

# Постов в базе должно быть хотя бы 200к
# Авторов лучше сделать в районе 100 штук,
100.times do |i|
  user = User.create(login: "User#{i}")
  2000.times do
    post = Post.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, author_ip: ips.sample, user: user)
    # Часть постов должна получить оценки
    Faker::Number.between(1, 3).times do
  	  Rating.create(value: Faker::Number.between(1, 5), post: post)
    end
  end
end