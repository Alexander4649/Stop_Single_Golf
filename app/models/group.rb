class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_comments, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  validates :group_name, presence: true
  
  has_one_attached :group_image
  
  def get_group_image
    group_image.attached? ? group_image : 'no_image.jpg'
  end
  
end
