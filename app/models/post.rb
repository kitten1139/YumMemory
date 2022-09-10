class Post < ApplicationRecord

  has_one_attached :image

  belongs_to :user
  belongs_to :item_category
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy

  validates :rate, presence: true
  validates :item_name, presence: true

end
