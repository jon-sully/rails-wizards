require "application_system_test_case"

class DesksTest < ApplicationSystemTestCase
  setup do
    @desk = desks(:one)
  end

  test "visiting the index" do
    visit desks_url
    assert_selector "h1", text: "Desks"
  end

  test "creating a Desk" do
    visit desks_url
    click_on "New Desk"

    fill_in "Color", with: @desk.color
    fill_in "Length", with: @desk.length
    fill_in "Material preference", with: @desk.material_preference
    fill_in "Sit height", with: @desk.sit_height
    fill_in "Stand height", with: @desk.stand_height
    fill_in "Width", with: @desk.width
    click_on "Create Desk"

    assert_text "Desk was successfully created"
    click_on "Back"
  end

  test "updating a Desk" do
    visit desks_url
    click_on "Edit", match: :first

    fill_in "Color", with: @desk.color
    fill_in "Length", with: @desk.length
    fill_in "Material preference", with: @desk.material_preference
    fill_in "Sit height", with: @desk.sit_height
    fill_in "Stand height", with: @desk.stand_height
    fill_in "Width", with: @desk.width
    click_on "Update Desk"

    assert_text "Desk was successfully updated"
    click_on "Back"
  end

  test "destroying a Desk" do
    visit desks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Desk was successfully destroyed"
  end
end
