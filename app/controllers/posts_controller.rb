class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @user = User.find(@user.id)
    @post_comment = PostComment.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.in_score = 1  #仮でつけてる
    @post.out_score = 1 #仮でつけてる
    @post.save
    redirect_to post_path(@post.id)
  end
  
  def index
    @posts = Post.all
    
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    else
      @posts = Post.all
    end
    
    @posts = Post.page(params[:page]).per(3)
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referer
  end
  
  private
  
  def post_params
      params.require(:post).permit(:title, :body, :post_image, :round_day, :in_score, :out_score, :round_place)
  end
  
  
end
