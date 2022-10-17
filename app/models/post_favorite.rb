class PostFavorite < ApplicationRecord

  belongs_to :post
  belongs_to :user
  # 1つの投稿に対して１つしかいいねをつけられない
  validates :post_id, uniqueness: {scope: :user_id}

end
