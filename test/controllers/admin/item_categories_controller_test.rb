require "test_helper"

class Admin::ItemCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_item_categories_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_item_categories_edit_url
    assert_response :success
  end
end
