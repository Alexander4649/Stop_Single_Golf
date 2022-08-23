#会員ステータスが退会のUser.idを抽出
namespace :is_delited_users do
  desc 'is_delited_users'
  task find: :environment do
    # 同じテーブルでis_deletedをinteger型にする場合
    @is_delited_users = User.where(is_deleted: 1)
    @is_deleted_users.each do |user|
      user.is_deleted = 2
      user.save
    end

    # 別テーブルで管理する場合
    @is_delited_users = User.where(is_deleted: true)
    @is_deleted_users.each do |user|
      RemoveReserveUser.create(user_id: user.id)
    end
  end
end