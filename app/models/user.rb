class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: :follow_id, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :follows, through: :relationships, source: :follower
  has_many :followers, through: :reverse_of_relationships, source: :follow
  has_many :bookmarks, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :group_users, dependent: :destroy
  has_many :group_comments, dependent: :destroy
  
    # 検索方法分岐
  def self.looks(search, word)
    @user = User.where("name LIKE?", "%#{word}%")
  end
  
  def follow_by?(user)
    reverse_of_relationships.find_by(follow_id: user.id).present?
  end
  
  has_one_attached :profile_image
  
  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end
end
