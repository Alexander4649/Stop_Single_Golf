#会員ステータスが退会のUser.idを抽出
namespace :is_delited_users do
  desc 'is_delited_users'
  task find: :environment do
    @is_delited_users = User.where(is_delited: true, user_id: user.id)
  end
end