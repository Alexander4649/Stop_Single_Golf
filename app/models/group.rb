class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users

  validates :group_name, presence: true
  
  has_one_attached :group_image
  
  def get_group_image
    group_image.attached? ? profile_image : 'no_image.jpg'
  end
end
