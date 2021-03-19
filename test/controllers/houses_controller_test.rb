require "test_helper"

class HousesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @house = houses(:one)
  end

  test "should get index" do
    get houses_url
    assert_response :success
  end

  test "should get new" do
    get new_house_url
    assert_response :success
  end

  test "should create house" do
    assert_difference('House.count') do
      post houses_url, params: { house: { address: @house.address, current_family_last_name: @house.current_family_last_name, exterior_color: @house.exterior_color, interior_color: @house.interior_color, rooms: @house.rooms, square_feet: @house.square_feet } }
    end

    assert_redirected_to house_url(House.last)
  end

  test "should show house" do
    get house_url(@house)
    assert_response :success
  end

  test "should get edit" do
    get edit_house_url(@house)
    assert_response :success
  end

  test "should update house" do
    patch house_url(@house), params: { house: { address: @house.address, current_family_last_name: @house.current_family_last_name, exterior_color: @house.exterior_color, interior_color: @house.interior_color, rooms: @house.rooms, square_feet: @house.square_feet } }
    assert_redirected_to house_url(@house)
  end

  test "should destroy house" do
    assert_difference('House.count', -1) do
      delete house_url(@house)
    end

    assert_redirected_to houses_url
  end
end
