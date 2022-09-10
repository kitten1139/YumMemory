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

end
