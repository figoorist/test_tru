class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  def index
    @posts = Post.all
    json_response(@posts)
  end

  # GET /posts/:id
  def show
    json_response(@post)
  end

  # POST /posts
  def create
  	if current_user = User.find_by(login: params[:login]) then
      @post = Post.create!(title: params[:title], body: params[:body], author_ip: request.remote_ip, user: current_user)
    else
      new_user = User.create!(login: params[:login])
      @post = Post.create!(title: params[:title], body: params[:body], author_ip: request.remote_ip, user: new_user)
  	end

  	json_response(@post)
  end

  # GET /posts/:id
  def show
    json_response(@post)
  end

  # 3. Получить топ N постов по среднему рейтингу. Просто массив объектов с заголовками и содержанием.
  # GET /posts/top/:n
  def top
    posts = Post.order(average_rating: :desc).first(params[:n].to_i)
    json_response(posts)
  end

  # 4. Получить список айпи, с которых постило несколько разных авторов. Массив объектов с полями: айпи и массив логинов авторов.
  # GET /posts/top/:n
  def ips
    posts = Post.select("author_ip, user_id").group(:author_ip, :user_id).having('COUNT(user_id) > 1')
    json_response(posts)
  end

  private

	  def set_post
	    @post = Post.find(params[:id])
	  end
end
