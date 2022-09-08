class ItemCategory < ApplicationRecord

  belongs_to :large_category
  has_many :posts, dependent: :destroy

  validates :name, presence: true

end
