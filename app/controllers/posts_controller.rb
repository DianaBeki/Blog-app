class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @user = User.find(params[:user_id])
    @likes = @post.likes.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.author = current_user

    if @post.save
      # Increment the user's posts_counter
      current_user.increment!(:posts_counter)

      flash[:notice] = 'Post was successfully created'
      redirect_to users_path
    else
      flash.now[:error] = 'An error has occurred. Post could not be created, Please try again later.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
