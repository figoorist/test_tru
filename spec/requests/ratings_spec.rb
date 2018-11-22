require 'rails_helper'

RSpec.describe 'Ratings API' do
  # Initialize the test data
  let!(:user) { create(:user_with_posts_with_ratings) }
  let(:post_id) { user.posts.first.id }

  # id оценки
  let(:id) { user.posts.first.ratings.first.id }
  let(:average_rating) { 4.2 }

  # get /posts/:post_id/ratings
  describe 'GET /posts/:post_id/ratings' do
    before { get "/posts/#{post_id}/ratings" }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all post ratings' do
        expect(json.size).to eq(4)
      end
    end

    context 'when post does not exist' do
      let(:post_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # get /posts/:post_id/ratings/:id
  describe 'GET /posts/:post_id/ratings/:id' do
    before { get "/posts/#{post_id}/ratings/#{id}" }

    context 'when post rating exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the rating' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when rating does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Rating/)
      end
    end
  end

  # post /posts/:post_id/ratings
  describe 'POST /posts/:post_id/ratings' do
    let(:valid_attributes) { { value: 1 } }

    context 'when request attributes are valid' do
      before { post "/posts/#{post_id}/ratings", params: valid_attributes }

      # возвращает новый средний рейтинг поста
      it 'returns average rating' do
        expect(json['average_rating']).to eq(average_rating)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when an invalid request' do
      before { post "/posts/#{post_id}/ratings", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Value must be given/)
      end
    end

    context 'when an invalid request' do
      before { post "/posts/#{post_id}/ratings", params: { value: 100500 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Value out of range/)
      end
    end

    context 'when post does not exist' do
      let(:post_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

end