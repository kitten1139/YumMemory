class CreateItemCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :item_categories do |t|
      t.integer :large_category_id, null: false
      t.integer :post_id, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
