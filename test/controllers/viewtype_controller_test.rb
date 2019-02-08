require 'test_helper'

class ViewtypeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get viewtype_index_url
    assert_response :success
  end

end
