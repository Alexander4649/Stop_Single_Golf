class Users::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(current_user)
  end
  
  protected
  
   # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def user_state
    @user = User.find_by(name: params[:user][:name])
    if @user 
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
  
end