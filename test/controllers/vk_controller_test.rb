require 'test_helper'

class VkControllerTest < ActionController::TestCase
  test "should get authenticate" do
    get :authenticate
    assert_response :success
  end

end
