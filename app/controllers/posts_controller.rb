class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @user = User.find(@user.id)
    @post_comment = PostComment.new
    @post_comments = PostComment.all
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
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def post_params
      params.require(:post).permit(:title, :body, :post_image, :round_day, :in_score, :out_score, :round_place)
  end
  
  
end
