class LargeCategory < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :posts, through: :item_categories

  validates :name, presence: true
end
