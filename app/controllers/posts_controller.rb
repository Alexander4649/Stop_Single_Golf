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
      redirect_to new_post_path, alert: '未入力があります。'
      # @score_result = {}
      # @score_result[:score_in] = params[:post][:f_score_in]
      # @score_result[:score_out] = params[:post][:f_score_in]
      # @score_result[:score_total] = params[:post][:f_score_total]
      # flash[:hoge] = "デモとしてflashを表示しています。"
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
       redirect_to edit_post_path(@post), alert: '未入力があります。'
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
