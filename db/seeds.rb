# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# adminユーザー
User.create!(
  name: '管理者',
  email: 'admin@example.com',
  password: 'admin1',
  password_confirmation: 'admin1',
  admin: true
)

# テストユーザー
User.create!(
  name: 'TestUser1', #メインユーザー
  email: 'testuser1@example.com',
  password: '111111',
  password_confirmation: '111111',
  round_area: '沖縄県',
  average_score: '88',
  experience: '8年8ヶ月',
)

# サブユーザー
User.create!(
  name: 'TestUser2',
  email: 'testuser2@example.com',
  password: 'test22',
  password_confirmation: 'test22',
  round_area: '北海道',
  average_score: '111',
  experience: '5年'
)

User.create!(
  name: 'TestUser3',
  email: 'testuser3@example.com',
  password: 'test33',
  password_confirmation: 'test33',
  round_area: 'シドニー',
  average_score: '94',
  experience: '6年5ヶ月'
)

User.create!(
  name: 'TestUser4',
  email: 'testuser4@example.com',
  password: 'test44',
  password_confirmation: 'test44',
  round_area: 'アテネ',
  average_score: '135',
  experience: '8ヶ月'
)