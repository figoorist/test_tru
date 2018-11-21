class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  def index
    @posts = Post.all
    json_response(@posts)
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

  private

	  def set_post
	    @post = Post.find(params[:id])
	  end
end
