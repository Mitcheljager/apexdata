require 'test_helper'

class WhereControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get where_index_url
    assert_response :success
  end

end
