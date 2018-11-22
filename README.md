# README

Ruby 2.5.3
Rails 5.2
postgresql-10

Спеки: bundle exec rspec

Валидаторы моделей: app/validators

Данные для входа в бд: .env, пример .env.example

rake db:drop db:create db:migrate

rake db:seed

rails s

Features:

1. Создать пост  :3000/posts title=<title> body=<body> login=<login>
2. Поставить оценку посту  :3000/posts/<id поста>/ratings value=<значение>
3. Получить топ N постов по среднему рейтингу  :3000/top/<N>
4. Получить список айпи, с которых постило несколько разных авторов   :3000/ips
