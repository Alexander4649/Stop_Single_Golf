class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
    @post.create_notification_post_comment!(current_user, @post_comment.id)#通知の作成
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find_by(post_id: params[:post_id], id: params[:id])
    @post_comment.destroy
  end
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
