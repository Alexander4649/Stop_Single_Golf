class Post < ApplicationRecord
  
  IMAGES_FILE_LIMIT = 5
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :rounds, dependent: :destroy
  accepts_nested_attributes_for :rounds, allow_destroy: true
  has_many :notifications, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :body, presence: true, length: { minimum: 2, maximum: 200 }
  validates :round_day, presence: true
  validates :round_place, presence: true, length: { minimum: 2, maximum: 20 }
  validate :images_amount
  # validates :post_image, presence: true
  
  # has_one_attached :post_image
  # has_many_attached :post_images
  mount_uploaders :images, ImageUploader
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  enum status: { published: 0, draft: 1 }
  
  # 添付ファイル数制限設定
  def images_amount
    if images.length > IMAGES_FILE_LIMIT
      errors.add(:images, "は5枚以内にしてください")
    end
  end
  
  def post_errors
    
  end
  
  def score_result
    score = self.rounds
    score_in = score.where(round_number: [*1..9]).map{ |o| o.score_before_type_cast }.sum
    score_out = score.where(round_number: [*10..18]).map{ |o| o.score_before_type_cast }.sum
    score_total = score_in + score_out
    { score_in: score_in, score_out: score_out, score_total: score_total }
  end
  
    # 検索方法分岐
  def self.looks(search, word)
    # if search == "タイトル"
      @post = Post.where("round_place LIKE?", "%#{word}%")
    # elsif search == "ラウンド場所"
    #   @post = Post.where("round_place LIKE?", "%#{word}%")
    # elsif search == "投稿者"
    #   @post = Post.name.where("post.name LIKE?", "%#{word}%")
    # elsif search == "場所"
    #   @post = Post.where("score_result LIKE?", "%#{word}%")
    # else
    #   @post = Post.all
    # end
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
  
  # Like通知機能
  def create_notification_by(current_user)
	    notification = current_user.active_notifications.new(
	      post_id: id,
	      visited_id: user_id,
	      action: "favorite"
	    )
	    # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
	    notification.save if notification.valid? #valid? => バリデーションが実行された結果、エラーが無い場合trueを返し，エラーが発生した場合falseを返す
	    
  end
  
  # 投稿コメント通知機能
  def create_notification_post_comment!(current_user, post_comment_id)
	    post_comment = PostComment.find(post_comment_id)
	    post = post_comment.post
	   if post.user != current_user
	     save_notification_post_comment!(current_user, post_comment_id, user_id)
	   end
	   #コメントをしたidを取得し、post_commentに代入
	   #コメントをされた投稿を取得し、postに代入
	   #もし、コメントをしたユーザーが本人ではない場合は、saveメソッドを実行する。
  end
  
  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        post_id: id,
        post_comment_id: post_comment_id,
        visited_id: visited_id,
        action: 'post_comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end

end
