require "application_system_test_case"

class TrainsTest < ApplicationSystemTestCase
  setup do
    @train = trains(:one)
  end

  test "visiting the index" do
    visit trains_url
    assert_selector "h1", text: "Trains"
  end

  test "creating a Train" do
    visit trains_url
    click_on "New Train"

    fill_in "Brand name", with: @train.brand_name
    fill_in "Color", with: @train.color
    fill_in "Height", with: @train.height
    fill_in "Length", with: @train.length
    fill_in "Maximum speed", with: @train.maximum_speed
    fill_in "Wheel count", with: @train.wheel_count
    fill_in "Width", with: @train.width
    click_on "Create Train"

    assert_text "Train was successfully created"
    click_on "Back"
  end

  test "updating a Train" do
    visit trains_url
    click_on "Edit", match: :first

    fill_in "Brand name", with: @train.brand_name
    fill_in "Color", with: @train.color
    fill_in "Height", with: @train.height
    fill_in "Length", with: @train.length
    fill_in "Maximum speed", with: @train.maximum_speed
    fill_in "Wheel count", with: @train.wheel_count
    fill_in "Width", with: @train.width
    click_on "Update Train"

    assert_text "Train was successfully updated"
    click_on "Back"
  end

  test "destroying a Train" do
    visit trains_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Train was successfully destroyed"
  end
end
