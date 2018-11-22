require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  # initialize test data 
  
  let!(:user) { create(:user_with_posts) }
  let!(:posts) { user.posts }
  let(:post_id) { posts.first.id }
  #Новый логин
  let(:login) { "l0g1n" }
  let(:ip) { "127.0.0.1" }
  let(:post_count) { 5 }
  let!(:local_post) { create(:post, user: user, author_ip: ip) }

  # GET /posts
  describe 'GET /posts' do
    # GET /posts
    before { get '/posts' }

    it 'returns posts' do
      #`json` хэлпер для разбора json
      expect(json).not_to be_empty
      expect(json.size).to eq(11)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # GET /posts/:id
  describe 'GET /posts/:id' do
    before { get "/posts/#{post_id}" }

    context 'when the record exists' do
      it 'returns the post' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for POST /posts
  describe 'POST /posts' do

    let(:valid_attributes) { { title: "Soluta error ut ut.", body: "Et aspernatur praesentium. Praesentium officia omnis. Maiores veritatis eaque.", login: user.login } }

    context 'when the request is valid and user already exist' do

      before { post '/posts', params: valid_attributes }

      # Параметры не могут быть пустыми
      it 'returns correct fields' do
        expect(json['title']).to eq(valid_attributes[:title])
        expect(json['body']).to eq(valid_attributes[:body])
        expect(json['user']['login']).to eq(valid_attributes[:login])
        expect(json['author_ip']).to eq(ip)
      end

      # Если пользователь уже есть в системе, новый не создается
      it 'user count isn\'t increased and user not create' do
        expect(User.count).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is valid and user doesn\'t exist yet' do

      before { post '/posts', params: valid_attributes.merge(login: login) }
    
      # Параметры не могут быть пустыми
      it 'returns correct fields' do
        expect(json['title']).to eq(valid_attributes[:title])
        expect(json['body']).to eq(valid_attributes[:body])
        expect(json['user']['login']).to eq(User.last.login)
        expect(json['author_ip']).to eq(ip)
      end

      # Если автора с таким логином еще нет, необходимо его создать
      it 'user login created' do
        expect(User.exists?(login: login)).to eq(true)
      end

      # Если автора с таким логином еще нет, увеличивается количество юзеров
      it 'user count isn\'t increased and user not create' do
        expect(User.count).to eq(2)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/posts', params: { title: '', body: '', login: login } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Title must be given/)
        expect(response.body).to match(/Body must be given/)
      end
    end
  end

  # 3. Получить топ N постов по среднему рейтингу. Просто массив объектов с заголовками и содержанием.
  # GET /posts/top/:n
  describe 'GET /top/:n' do
    before { get "/top/#{post_count}" }

    it 'returns the posts' do
      expect(json).not_to be_empty
      expect(json.count).to eq(post_count)
    end
  end

  # 4. Получить список айпи, с которых постило несколько разных авторов. Массив объектов с полями: айпи и массив логинов авторов.
  # GET /posts/ips
  describe 'GET /ips' do
    before do
      create(:post, user: user, author_ip: ip)
      # Создаем пост для еще одного ip
      create(:post, user: user, author_ip: posts.first.author_ip)
      get "/ips"
    end

    it 'returns the ips' do
      expect(json).to_not be_empty
      expect(json.size).to eq(2)
      json.each do |item|
        expect([ip, posts.first.author_ip].include?(item['author_ip'])).to eq(true)
      end
    end
  end
end