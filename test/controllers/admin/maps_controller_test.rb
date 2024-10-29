require "test_helper"

class Admin::MapsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_maps_show_url
    assert_response :success
  end
end
