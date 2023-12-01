class PostsController < ApplicationController
  before_action :set_user, only: %i[index show new create]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
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
      redirect_to user_post_path(@current_user, @post), notice: 'Post was successfully created'
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    render_404 unless @user
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
