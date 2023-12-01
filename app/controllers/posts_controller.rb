class PostsController < ApplicationController
  before_action :set_user, only: %i[index show new create]
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    authorize! :destroy, @post

    @post.destroy
    redirect_to user_posts_path(current_user), notice: 'Post was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  
    if @user.nil?
      redirect_to root_path, alert: 'User not found.'
    end
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
