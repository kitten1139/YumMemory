require "test_helper"

class Public::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_categories_index_url
    assert_response :success
  end
end
