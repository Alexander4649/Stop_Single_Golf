class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    @post.create_notification_favorite!(current_user, @post.id)#通知の作成
    # @post.create_notification_by(current_user)
    #   respond_to do |format|
    #     format.html {redirect_to request.referrer}
    #     format.js
    #   end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
  
end