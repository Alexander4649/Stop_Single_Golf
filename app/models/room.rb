class Room < ApplicationRecord
  has_many :chats
  has_many :user_rooms  #1つのルームにいるユーザ数は2人のためhas_manyになる
end
