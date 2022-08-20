class SearchesController < ApplicationController
    before_action :authenticate_user! # ログイン中か確認

  def search
    @range = params[:range]
    @search = params[:search]
    @word = params[:word]

    if @range == "Name"
      @users = User.looks(params[:search], params[:word]).page(params[:page]).per(7) # ゲストユーザー・管理者が含まれているので、1ページ目は5名となる 
    elsif @range == "Place"
      @posts = Post.published.looks(params[:search], params[:word]).page(params[:page]).per(3)
    else
      redirect_to request.referer
    end
  end
end

#   検索モデル→params[:range]
# 　検索方法→params[:search]
# 　検索ワード→params[:word]
