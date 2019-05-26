require 'test_helper'

class DistributedBadgesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get distributed_badges_index_url
    assert_response :success
  end

  test "should get update" do
    get distributed_badges_update_url
    assert_response :success
  end

end
