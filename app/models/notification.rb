class Notification < ApplicationRecord
  
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true #post_idにnilを許容するもの
	belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
  #スコープ(新着順)
	default_scope->{order(created_at: :desc)}
end
