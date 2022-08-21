class UsersController < ApplicationController
  before_action :authenticate_user! #ログイン中か確認
  before_action :ensure_correct_user, only: [:edit, :update] #機能制限
  #before_action :ensure_guest_user, only: [:edit] #ゲストユーザーに機能制限
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.published.page(params[:page]).reverse_order.per(4)
    if !current_user.admin && @user.admin # ログインユーザが管理者ではない 且 管理者のページである => 両方の条件を満たす時リダイレクトしたいため。
      redirect_to user_path(current_user)
    end
  end
  
  # User一覧(管理者専用)
  def index
    if current_user.name == "管理者"
      @users = User.all
      # .where.not(admin)
    else
      redirect_to user_path(current_user)
    end
    
    @users = @users.page(params[:page]).per(7)
  end
  
  #管理者はeditに遷移できない
  def edit
    @user = User.find(params[:id])
    if current_user.admin?
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  # User削除(管理者専用)
  def destroy
    if current_user.name == "管理者"
       @user = User.find(params[:id])
       @user.destroy
       Group.where(user_id: @user.id).destroy_all #groupのdependent: :destroyが反応しない為、直接記述しています。中間テーブルを使用しているとdestroyが反応しない模様・・・
       redirect_to users_path
    else
       redirect_to request.referer
    end
  end
  
   # 退会確認画面
  def unsubscribe
    @user = User.find(params[:id])
  end
  
  # 退会機能
  def withdraw
     @user = User.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  # 復元機能(管理者専用)
  def restoration
    if current_user.name == "管理者"
      @user = User.find(params[:id])
      @user.update(is_deleted: false)
      redirect_to users_path
    else
      redirect_to request.referer
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :round_area, :average_score, :experience, :is_deleted)
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
