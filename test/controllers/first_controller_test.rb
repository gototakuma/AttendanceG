require 'test_helper'

class FirstControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get first_home_url
    assert_response :success
  end

end
