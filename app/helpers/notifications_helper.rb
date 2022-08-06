module NotificationsHelper
  
  # 本来はbefore_actionにてコントローラに定義するのが好ましい。
def notification_form(notification)
  @visiter = notification.visiter
  @post_comment = nil
  @post = link_to 'あなたの投稿', post_path(notification), style: "font-weight: bold;"
  @visiter_post_comment = notification.post_comment_id
  
  # notification.actionがfollowかlikeかcommentか
  # caseはifと同等の性能があるが、ifの場合だと、条件文に、if notification.action follow? みたいな感じでいちいち条件を書かないといけないので、今回はcase文にして簡略化している
  case notification.action
    when "follow" then
      tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
    when "favorite" then
      tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post.id), style:"font-weight: bold;")+"にGood!しました"
    when "post_comment" then
    	@post_comment = PostComment.find_by(id: @visiter_post_comment)&.comment
    	tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post.id), style:"font-weight: bold;")+"にコメントしました"
  end
end

def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
end

end
