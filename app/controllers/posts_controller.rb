class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to user_path(@post.id)
  end
  
  def index
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def post_params
      params.require(:post).permit(:title, :body, :post_image, :day, :score, :place)
  end
  
  
end
