#抽出したUser.idを全削除
namespace :destroy_users do
  desc 'destroy_users'
  task destroy: :environment do
    @is_delited_users.destroy_all
  end
end