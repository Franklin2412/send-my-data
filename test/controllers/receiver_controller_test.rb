require 'test_helper'

class ReceiverControllerTest < ActionController::TestCase
  test "should get success" do
    get :success
    assert_response :success
  end

  test "should get failure" do
    get :failure
    assert_response :success
  end

end
