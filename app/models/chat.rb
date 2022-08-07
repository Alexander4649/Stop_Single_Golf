class Chat < ApplicationRecord
   belongs_to :user
   belongs_to :room
   
   validates :message, presence: true, length: { minimum: 1, maximum: 500 }
end
