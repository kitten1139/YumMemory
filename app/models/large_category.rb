class LargeCategory < ApplicationRecord

  has_many :item_categories, dependent: :destroy
  
  validates :name, presence: true

end
