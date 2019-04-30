require 'test_helper'

class EventLegendDataControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_legend_data_create_url
    assert_response :success
  end

  test "should get update" do
    get event_legend_data_update_url
    assert_response :success
  end

end
