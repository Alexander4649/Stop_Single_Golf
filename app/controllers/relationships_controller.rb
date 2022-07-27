class RelationshipsController < ApplicationController
  def create
    follow = Relationship.new(follow_id: current_user.id ,follower_id: params[:user_id])
    follow.save
    @user = User.find(params[:user_id])
    #redirect_to request.referer
  end
  
  def destroy
    follow = Relationship.find_by(follow_id: current_user.id ,follower_id: params[:user_id])
    follow.destroy
    @user = User.find(params[:user_id])
    #redirect_to request.referer
  end
  
  def follows
    @user = User.find(params[:user_id])
    @users = @user.follows
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end
end
