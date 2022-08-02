class SearchesController < ApplicationController
    #before_action :authenticate_user!

  def search
    @range = params[:range]
    @search = params[:search]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    elsif @range == "Post"
      @posts = Post.looks(params[:search], params[:word])
    end

    # @posts = Post.where(tag: params[:word])
  end
end

#   検索モデル→params[:range]
# 　検索方法→params[:search]
# 　検索ワード→params[:word]
