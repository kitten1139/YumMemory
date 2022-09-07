class LargeCategory < ApplicationRecord

  has_many :item_categories, dependent: :destroy

end
