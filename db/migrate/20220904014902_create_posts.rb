class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :item_category_id, null: false
      t.float :rate, null: false
      t.string :review_title
      t.text :review_body
      t.string :item_name, null: false

      t.timestamps
    end
  end
end
