# README
RestAPI: this is the Blog with models: user(login), post(title, body, author ip, belongs to user), rating(value[1..5], belongs to post). Following actions are implemented:
1. Create post. Params: title, body, login, author IP. If user with login not exists, needs create new user. Responses: post attributes with 200 OK or 422
2. Rate a post. Params: post id, rating value. Responses: new average post rating.
3. Get first N posts ordered by average rating.
4. Get IP addresses with more then 1 users. Like [ip=>[user1, user2], [ip2=>[user1, user3]]



Ruby 2.5.3
Rails 5.2
postgresql-10

Specs: bundle exec rspec

Model validations: app/validators

db login details(dotenv): .env, ex. .env.example

rake db:drop db:create db:migrate

rake db:seed

rails s

Features:

1. Create post  :3000/posts title=<title> body=<body> login=<login>
2. Rate post  :3000/posts/<id поста>/ratings value=<value>
3. Get first N posts ordered by average  :3000/top/<N>
4. Get IP addresses with more then 1 users   :3000/ips
