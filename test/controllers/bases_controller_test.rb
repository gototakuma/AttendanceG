require 'test_helper'

class BasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bases_index_url
    assert_response :success
  end

  test "should get update" do
    get bases_update_url
    assert_response :success
  end

  test "should get create" do
    get bases_create_url
    assert_response :success
  end

  test "should get edit" do
    get bases_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get bases_destroy_url
    assert_response :success
  end

end
