class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    post_id = @post
    favorite = current_user.favorites.new(post_id: post_id.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_id = @post
    favorite = current_user.favorites.find_by(post_id: post_id.id)
    favorite.destroy
    redirect_to request.referer
  end
end