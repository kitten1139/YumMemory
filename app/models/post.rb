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
  scope :score_count, -> {order(score: :asc)}#スコアが低い順に取り出し

  #公開を選択している投稿を取得
  def self.privacy
    Post.where(privacy: 0)
  end

  #商品画像
  def get_item_image
    (item_image.attached?) ? item_image : 'item_no_image.jpg'
  end

  #いいねされているかの判定
  def post_favorited_by?(user)
    post_favorites.exists?(user_id: user.id)
  end

  # 商品名またはスーパー名でキーワード検索
  def self.looks(word)
    @post = Post.where("item_name LIKE?","%#{word}%").or(Post.where("store_name LIKE?","%#{word}%"))
  end

end
