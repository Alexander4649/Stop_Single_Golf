class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(current_user)
  end
  
  private
  
  def user_params
    params.permit(:name, :profile_image, :round_area, :average_score, :experience)
  end
  
end
