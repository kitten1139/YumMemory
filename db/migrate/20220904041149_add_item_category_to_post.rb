class AddItemCategoryToPost < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :introduction, true
    change_column_null :users, :favorite_food, true
  end
end
