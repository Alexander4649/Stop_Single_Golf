class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :user_id, uniqueness: { scope: :post_id }
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
end
