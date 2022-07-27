class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  
  
  has_one_attached :post_image
  
  def total_score
    out_score + in_score
  end
  
end
