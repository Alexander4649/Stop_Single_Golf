#会員ステータスが退会のUser.idを抽出
namespace :is_deleted_users do
  desc 'is_deleted_users'
  task find: :environment do

    # 別テーブルで管理する場合
    # 毎週金曜日24時に会員ステータスが退会のUserにidを付与
    @is_deleted_users = User.where(is_deleted: true) # 退会ステータスのuserを削除対象リストに格納
    @is_deleted_users.each do |user| # 削除対象リストのuserにuser.idを付与
      RemoveReserveUser.create(user_id: user.id)
    end
  end
end


# 同じテーブルでis_deletedをinteger型にする場合
# @is_delited_users = User.where(is_deleted: 1)
# @is_deleted_users.each do |user|
#   user.is_deleted = 2
#   user.save
# end