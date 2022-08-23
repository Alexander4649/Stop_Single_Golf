#抽出したUser.idを全削除
namespace :destroy_users do
  desc 'destroy_users'
  task destroy: :environment do
    # 同じテーブルでis_deletedをinteger型にする場合
    User.where(is_deleted: 2).destroy_all

    # 別テーブルで管理する場合
    @is_delited_users = RemoveReserveUser.all
    User.where(user_id: @is_delited_users).destroy_all
    RemoveReserveUser.all.destroy_all
  end
end