class ItemCategory < ApplicationRecord

  belongs_to :large_category
  has_many :posts, dependent: :destroy

end
