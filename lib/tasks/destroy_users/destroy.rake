#抽出したUser.idを全削除
namespace :destroy_users do
  desc 'destroy_users'
  task destroy: :environment do
    
    # 別テーブルで管理する場合
    # 毎週日曜日24時に削除対象リストのUser.idを全削除
    @is_deleted_users = RemoveReserveUser.all # 削除対象リストにあるuserを全て取得
    User.find(user_id: @is_deleted_users).destroy_all # 削除対象userのuser.idを探し、全て削除(完全削除)
    # User.where(user_id: @is_deleted_users).destroy_all
    RemoveReserveUser.all.destroy_all # 削除対象リストのuserを全て削除(リセットみたいな)
  end
end

# 同じテーブルでis_deletedをinteger型にする場合
# User.where(is_deleted: 2).destroy_all