require 'test_helper'

class OverTimesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get over_times_update_url
    assert_response :success
  end

  test "should get edit" do
    get over_times_edit_url
    assert_response :success
  end

end
