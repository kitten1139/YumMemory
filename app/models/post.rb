class Post < ApplicationRecord

  has_one_attached :item_image

  belongs_to :user
  belongs_to :item_category
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy

  validates :rate, presence: true
  validates :item_name, presence: true

  scope :latest, -> {order(created_at: :desc)}#投稿日時が新しい順に取り出し
  scope :old, -> {order(created_at: :asc)}#投稿日時が古い順に取り出し
  scope :rate_count, -> {order(rate: :desc)}#評価が高い順に取り出し

  def self.privacy
    Post.where(privacy: 0)
  end

  def get_item_image
    (item_image.attached?) ? item_image : 'item_no_image.jpg'
  end

  #いいねされているかの判定
  def post_favorited_by?(user)
    post_favorites.exists?(user_id: user.id)
  end

  # キーワード検索の検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("item_name LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("item_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("item_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("item_name LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
