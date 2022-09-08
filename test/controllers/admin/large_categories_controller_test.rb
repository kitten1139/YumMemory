require "test_helper"

class Admin::LargeCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_large_categories_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_large_categories_edit_url
    assert_response :success
  end
end
