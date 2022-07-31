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
    score_total = score_out + score_in
    if @post.save
       redirect_to post_path(@post.id)
    else
       render :new
    end
  end
  
  def index
    posts = Post.all
    if params[:latest]
      posts = Post.latest
    elsif params[:old]
      posts = Post.old
    else
      posts = Post.all
    end
    
    @posts = posts.page(params[:page]).per(3)
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
      params.require(:post).permit(:title, :body, :post_image, :round_day, :score_in, :score_out, :round_place)
  end
  
  
end
