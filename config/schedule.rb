# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

  
#毎週金曜日24時に会員ステータスが退会のUser.idを抽出
every :Friday, at: '24:00' do 
  begin
    rake 'is_deleted_users:find'
  rescue => e #例外処理とは、プログラムが想定していないデータが入力された場合、プログラムを異常で中断させることなく利用者や管理者に通知する処理に切り替える仕組み(レスキュー)
    Rails.logger.error("aborted rake task")
    raise e #エラーが起きた時はlogで教えてね的な感じ(レイズ)
  end
end

#毎週日曜日24時に抽出したUser.idを全削除
every :sunday, at: '24:00' do
  begin
    rake 'destroy_users:destroy'
  rescue => e #例外処理とは、プログラムが想定していないデータが入力された場合、プログラムを異常で中断させることなく利用者や管理者に通知する処理に切り替える仕組み(レスキュー)
    Rails.logger.error("aborted rake task")
    raise e #エラーが起きた時はlogで教えてね的な感じ(レイズ)
  end
end


# stagingのみで実行
# clear cache

# if rails_env.to_sym != :development
  # every :friday, at: '12pm' do
#     begin
#       rake 'is_deleted_users:find', :environment_variable => "RAILS_ENV", :environment => "development"
#     rescue => e
#       Rails.logger.error("aborted rake task")
#       raise e
#     end
#   end
# end

# if rails_env.to_sym != :development
#   every :sunday, at: '12pm' do 
#     begin
#       rake 'destroy_users:destroy', :environment_variable => "RAILS_ENV", :environment => "development"
#     rescue => e
#       Rails.logger.error("aborted rake task")
#       raise e
#     end
#   end
# end


#begin～rescue～endの基本構文

# begin
# 例外が起こるかも知れない処理
# rescue
# 例外が発生した時の処理
# end