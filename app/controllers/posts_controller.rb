class PostsController < ApplicationController
  before_action :authenticate_user! # ログイン中か確認
  before_action :ensure_correct_user, only: [:edit, :update] # ログイン中のユーザーにのみ、機能させるアクション指定
  
  #管理者は記事作成に遷移できない
  def new
    @post = Post.new
    @rounds = []
    18.times { |n| @rounds << @post.rounds.build(round_number: n + 1) }
    if current_user.admin?
      redirect_to user_path(current_user)
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    redirect_to user_path(current_user) if !@post.published? && current_user.id != @user.id #下書きであり　且　ログインユーザーIDと@userのIDが違う場合はページ遷移できない
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
    end
  end
  
  def index
    posts = Post.all
    @posts = Post.published.page(params[:page]).reverse_order.per(3) #投稿するタグを選択した場合のみ取得する
    
    if params[:latest]
      posts = Post.latest
    elsif params[:old]
      posts = Post.old
    else
      posts = Post.all
    end
    
  end
  
  def confirm
    @posts = current_user.posts.draft.page(params[:page]).reverse_order.per(4) #下書きするタグを選択した場合のみ取得する
    if current_user.admin?
      redirect_to user_path(current_user)
    end
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
      params.require(:post).permit(:title, :body, :post_image, :round_day, :score_in, :score_out, :round_place, :status, rounds_attributes: [:round_number, :score, :id], images: [])
  end
  
  def ensure_correct_user # before_actionによる定義。ログイン中のユーザーを判別する定義
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
  
  
end
