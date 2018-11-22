# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


# Постов в базе должно быть хотя бы 200к
# Авторов лучше сделать в районе 100 штук,
10.times do |i|
  user = User.create(login: "user#{i}")
  # айпишников использовать штук 50 разных
  5.times do
  	ip = Faker::Internet.ip_v4_address
  	4.times do
	  title = Faker::Lorem.sentence
	  body = Faker::Lorem.paragraph
	  post = Post.create(title: title, body: body, author_ip: ip, user: user)
	  # Часть постов должна получить оценки
	  special = Random.new 42
	  rand(3).times do
	  	Rating.create(value: special.rand(1..5), post: post)
	  end
	end

  end
end