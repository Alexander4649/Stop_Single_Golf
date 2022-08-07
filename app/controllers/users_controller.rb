class UsersController < ApplicationController
  before_action :authenticate_user! #ログイン中か確認
  before_action :ensure_correct_user, only: [:edit, :update] #機能制限
  #before_action :ensure_guest_user, only: [:edit] #ゲストユーザーに機能制限
  
  def show
    @user = User.find(params[:id])
    posts = @user.posts
    @posts = posts.page(params[:page]).per(6)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :round_area, :average_score, :experience)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  # ポートフォリオ提出時はOFFにしておく
  # def ensure_guest_user
  #   @user = User.find(params[:id])
  #   if @user.name == "ゲストユーザー"
  #     redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
  #   end
  # end
  
end
