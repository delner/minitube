require 'test_helper'

class PolicyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get country" do
    get :country
    assert_response :success
  end

  test "should get video" do
    get :video
    assert_response :success
  end

end
