class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
    #redirect_to request.referer
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find_by(post_id: params[:post_id], id: params[:id])
    @post_comment.destroy
    #redirect_to request.referer
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
