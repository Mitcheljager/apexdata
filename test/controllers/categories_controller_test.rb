require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get categories_index_url
    assert_response :success
  end

  test "should get show" do
    get categories_show_url
    assert_response :success
  end

end
