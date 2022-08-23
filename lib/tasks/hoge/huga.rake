# namespace :hoge do
#   desc 'hoge'
#   # config/environment.rbを読み込み、環境ごとの設定を反映してからhugaを実行
#   task huga: :environment do
#     # p ::SQLite3::VERSION
#     Contact.last.destroy #動作テスト用
#   end
# end