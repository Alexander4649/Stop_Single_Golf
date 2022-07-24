class Post < ApplicationRecord
  belongs_to :user
  
  
  
  has_one_attached :post_image
  
  def total_score
    out_score + in_score
  end
end
