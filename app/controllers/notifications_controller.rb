class NotificationsController < ApplicationController
  
  def index
      @notifications = current_user.passive_notifications
      @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
      end
      #current_userの投稿に紐づいた通知全てを取得
      #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ表示される
      #中身を確認するとcheckがtrueになり、通知表示が消える
  end
  
      #通知を全削除
  def destroy_all
      @notifications = current_user.passive_notifications.destroy_all
      redirect_to notifications_path
  end
end
