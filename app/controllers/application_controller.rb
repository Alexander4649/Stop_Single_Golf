class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_state, only: [:create]
  # before_action :authenticate_user

  private

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    home_logout_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  # ログインしていないユーザーがログインしているページに入ろうとした場合にログインページに遷移する
  # def authenticate_user
  #   if @current_user == nil
  #     redirect_to("/users/sign_in")
  #   end
  # end
  protected
  
   # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def user_state
  end
end
