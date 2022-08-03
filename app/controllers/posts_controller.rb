class PostsController < ApplicationController
  
  def new
    @post = Post.new
    @rounds = []
    18.times { |n| @rounds << @post.rounds.build(round_number: n + 1) }
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @user = User.find(@user.id)
    @post_comment = PostComment.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
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
    if @post.update(post_params)
       redirect_to post_path(@post.id)
    else
       render "edit"
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referer
  end
  
  private
  
  def post_params
      params.require(:post).permit(:title, :body, :post_image, :round_day, :score_in, :score_out, :round_place, rounds_attributes: [:round_number, :score, :id])
  end
  
  
end
