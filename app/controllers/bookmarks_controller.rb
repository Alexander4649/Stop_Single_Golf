class BookmarksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if params[:latest]
      @bookmarks = current_user.bookmarks.latest.page(params[:page]).per(3)
    elsif params[:old]
      @bookmarks = current_user.bookmarks.old.page(params[:page]).per(3)
    else
      @bookmarks = current_user.bookmarks.all.page(params[:page]).per(3)
    end
    
    if current_user.admin?
      redirect_to user_path(current_user)
    end
  end

  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new
    bookmark.user_id = current_user.id
    bookmark.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = Bookmark.find_by(post_id: params[:post_id])
    bookmark.user_id = current_user.id
    bookmark.destroy
  end
end
