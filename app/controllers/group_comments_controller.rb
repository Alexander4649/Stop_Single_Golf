class GroupCommentsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group_comment = current_user.group_comments.new(group_comment_params)
    @group_comment.group_id = @group.id
    @group_comment.save
    redirect_to request.referer
  end
  
  def destroy
    @group = Group.find(params[:group_id])
    @group_comment = GroupComment.find_by(group_id: params[:group_id], id: params[:id])
    @group_comment.destroy
    redirect_to request.referer
  end
  
  private
  
  def group_comment_params
    params.require(:group_comment).permit(:comment)
  end
end
