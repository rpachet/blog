class PostsController < ApplicationController
  before_action  :authenticate_user!, :except => [:show, :index]
  before_action :load_post, only: [:show, :edit, :update]


  def index
    if params[:user_id]
      @posts = Post.find_by(user_id: params[:user_id])
    else
      @posts = Post.all.order(:title)

    end
  end

  def load_post
    @post = Post.find(params[:id])

  end


  def new
    @post = Post.new
  end

  def create

    @post = Post.new authorized_attributes
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render 'create'
    end
  end

  def authorized_attributes
    params.require(:post).permit(:title, :publication_date, :header, :file)
  end


  def destroy
    @user= Post.find(params["id"])
    @user.destroy
    redirect_to posts_url
  end

end
