class RelationshipsController < ApplicationController
  before_action :authenticate_user! # ログインしているか確認!
  
  def create
    follow = Relationship.new(follow_id: current_user.id ,follower_id: params[:user_id])
    follow.save
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)#通知の作成
  end
  
  def destroy
    follow = Relationship.find_by(follow_id: current_user.id ,follower_id: params[:user_id])
    follow.destroy
    @user = User.find(params[:user_id])
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
