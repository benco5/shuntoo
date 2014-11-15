require 'test_helper'

  def setup
    @user = users(:bob)
  end

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
end
