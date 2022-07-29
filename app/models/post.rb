class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :round_day, presence: true
  validates :round_place, presence: true
  validates :post_image, presence: true
  
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  has_one_attached :post_image
  
  def total_score
    out_score + in_score
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
