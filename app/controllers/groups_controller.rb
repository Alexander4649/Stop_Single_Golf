class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
    
  end
  
  def index
    @groups = Group.all
  end
  
  def show
    @group = Group.find(params[:id])
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
    @group = Group.find(params[:id])
  end
  
  private
  
  def group_params
    params.require(:group).permit(:group_name, :round_day, :round_place,:image)
  end
end
