class RatingsController < ApplicationController
  before_action :set_post
  before_action :set_post_rating, only: [:show]

  # GET /posts/:post_id/ratings
  def index
    json_response_rating(@post.ratings)
  end

  # GET /posts/:post_id/ratings/:id
  def show
    json_response_rating(@rating)
  end

  # POST /posts/:post_id/ratings
  def create
    @post.ratings.create!(rating_params)
    json_response_rating(average_rating: @post.average_rating)
  end

  private

  	def rating_params
  	  params.permit(:value)
  	end

  	def set_post
  	  @post = Post.find(params[:post_id])
  	end

  	def set_post_rating
  	  @rating = @post.ratings.find_by!(id: params[:id]) if @post
  	end
end
