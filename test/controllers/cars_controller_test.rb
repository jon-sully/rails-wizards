require "test_helper"

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car = cars(:one)
  end

  test "should get index" do
    get cars_url
    assert_response :success
  end

  test "should get new" do
    get new_car_url
    assert_response :success
  end

  test "should create car" do
    assert_difference('Car.count') do
      post cars_url, params: { car: { exterior_color: @car.exterior_color, interior_material: @car.interior_material, preferred_engine_type: @car.preferred_engine_type, ride_height: @car.ride_height, seat_count: @car.seat_count, transmission_type: @car.transmission_type } }
    end

    assert_redirected_to car_url(Car.last)
  end

  test "should show car" do
    get car_url(@car)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_url(@car)
    assert_response :success
  end

  test "should update car" do
    patch car_url(@car), params: { car: { exterior_color: @car.exterior_color, interior_material: @car.interior_material, preferred_engine_type: @car.preferred_engine_type, ride_height: @car.ride_height, seat_count: @car.seat_count, transmission_type: @car.transmission_type } }
    assert_redirected_to car_url(@car)
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete car_url(@car)
    end

    assert_redirected_to cars_url
  end
end
