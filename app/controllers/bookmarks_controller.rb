class BookmarksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # @bookmarks = Bookmark.all
    #@bookmarks = Bookmark.where(user_id: current_user.id)
    if params[:latest]
      @bookmarks = Bookmark.latest.page(params[:page]).per(3)
    elsif params[:old]
      @bookmarks = Bookmark.old.page(params[:page]).per(3)
    else
      @bookmarks = Bookmark.all.page(params[:page]).per(3)
    end
  end

  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new
    bookmark.user_id = current_user.id#post_id: [:@post.id]
    if bookmark.save
      # redirect_to request.referer
    else
       redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = Bookmark.find_by(post_id: params[:post_id])#post_id: [:@post.id]
    bookmark.user_id = current_user.id
    if bookmark.destroy
      # bookmark.destroy!
      # redirect_to require.referer
    else
       redirect_to request.referer
    end
      
  end
end
