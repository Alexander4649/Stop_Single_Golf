class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.user_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
    
  end
  
  def index
    @groups = Group.all
    @groups = @groups.page(params[:page]).per(4)
  end
  
  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    #redirect_to  groups_path
  end
  
  def out
    @group = Group.find(params[:group_id])
    @group.users.destroy(current_user)
    #redirect_to groups_path
  end
  
  def show
    @group = Group.find(params[:id])
    @owner = User.find(@group.owner_id)
    @group_comment = GroupComment.new
    @group_users = @group.users.all
    # @group_users = Group.users.find(params[:user_id])
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end
  
  def destroy
    #byebug
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end
  
  private
  
  def group_params
    params.require(:group).permit(:group_name, :round_day, :round_place,:group_image)
  end
end
