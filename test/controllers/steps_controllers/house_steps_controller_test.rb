require "test_helper"

class StepsControllers::HouseStepsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get steps_controllers_house_steps_show_url
    assert_response :success
  end

  test "should get update" do
    get steps_controllers_house_steps_update_url
    assert_response :success
  end
end
