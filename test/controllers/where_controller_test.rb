require 'test_helper'

class WhereControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get where_path("name", "test")
    assert_response :success
  end

end
