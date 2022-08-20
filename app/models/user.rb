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
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  
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
  
  #フォロー時の通知
 def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
 end
 
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end
 
 #ゲストユーザー情報
 def self.guest
   find_or_create_by!(email: 'guest@example.com') do |user|
     user.password = SecureRandom.urlsafe_base64
     user.password_confirmation = user.password
     user.name = "ゲストユーザー"
     user.round_area = '東京都'
     user.average_score = '100'
     user.experience = "1年"
   end
 end
  
end
