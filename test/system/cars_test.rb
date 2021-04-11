require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @car = cars(:one)
  end

  test "visiting the index" do
    visit cars_url
    assert_selector "h1", text: "Cars"
  end

  test "creating a Car" do
    visit cars_url
    click_on "New Car"

    fill_in "Exterior color", with: @car.exterior_color
    fill_in "Interior material", with: @car.interior_material
    fill_in "Preferred engine type", with: @car.preferred_engine_type
    fill_in "Ride height", with: @car.ride_height
    fill_in "Seat count", with: @car.seat_count
    fill_in "Transmission type", with: @car.transmission_type
    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "updating a Car" do
    visit cars_url
    click_on "Edit", match: :first

    fill_in "Exterior color", with: @car.exterior_color
    fill_in "Interior material", with: @car.interior_material
    fill_in "Preferred engine type", with: @car.preferred_engine_type
    fill_in "Ride height", with: @car.ride_height
    fill_in "Seat count", with: @car.seat_count
    fill_in "Transmission type", with: @car.transmission_type
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  test "destroying a Car" do
    visit cars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car was successfully destroyed"
  end
end
