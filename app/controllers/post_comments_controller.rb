class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
  end
  
  def destroy
    #PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    #@post = Post.find(params[:post_id])
    #PostComment.find(params[:post_id]).destroy
    #redirect_to request.referer
    # @post = Post.find(params[:post_id])
    # @post_comment = PostComment.find(params[:post_comment_id])
    # current_user.id == @post_comment.user.id
    # @post_comment.destroy
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
