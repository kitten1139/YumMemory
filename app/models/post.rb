class Post < ApplicationRecord

  has_one_attached :item_image

  belongs_to :user
  belongs_to :item_category
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy

  validates :rate, presence: true
  validates :item_name, presence: true

  def get_item_image
    (item_image.attached?) ? item_image : 'item_no_image.jpg'
  end

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
