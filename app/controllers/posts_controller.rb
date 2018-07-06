class PostsController < ApplicationController
  before_action  :authenticate_user!, :except => [:show, :index]
  before_action :load_post, only: [:show, :edit, :update, :destroy]


  def index
    if params[:user_id]
      @posts = Post.where(user_id: params[:user_id])
    else
      @posts = Post.all.order(:title)

    end
  end

  def load_post
    @post = Post.find(params[:id])

  end

  def update
    if @post.user == current_user
      if @post.update_attributes(authorized_attributes)
          @post.user = @user
        redirect_to  [@user,@post]
      else
        render 'edit'
      end
    else
      redirect_to posts_url
    end
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

    if @post.user == current_user

      @post.destroy
    end
    redirect_to posts_url
  end

end
