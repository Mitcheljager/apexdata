require 'test_helper'

class EventSignupsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_signups_create_url
    assert_response :success
  end

  test "should get update" do
    get event_signups_update_url
    assert_response :success
  end

  test "should get destroy" do
    get event_signups_destroy_url
    assert_response :success
  end

end
