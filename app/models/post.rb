class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :rounds, dependent: :destroy
  accepts_nested_attributes_for :rounds, allow_destroy: true
  
  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :body, presence: true, length: { minimum: 2, maximum: 200 }
  validates :round_day, presence: true
  validates :round_place, presence: true, length: { minimum: 2, maximum: 30 }
  validates :post_image, presence: true
  
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  has_one_attached :post_image
  
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

end
