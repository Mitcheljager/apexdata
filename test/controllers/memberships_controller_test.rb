require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get memberships_new_url
    assert_response :success
  end

  test "should get create" do
    get memberships_create_url
    assert_response :success
  end

end
