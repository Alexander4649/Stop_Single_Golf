class Notification < ApplicationRecord
  
  #スコープ(新着順)
	default_scope->{order(created_at: :desc)}

  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true #item_idにnilを許容するもの
	belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
	
	has_one_attached :profile_image
  
  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end
  
end
