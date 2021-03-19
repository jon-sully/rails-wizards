require "test_helper"

class UserControllers::StepsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_controllers_steps_show_url
    assert_response :success
  end

  test "should get update" do
    get user_controllers_steps_update_url
    assert_response :success
  end
end
