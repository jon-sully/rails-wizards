require "application_system_test_case"

class ComputersTest < ApplicationSystemTestCase
  setup do
    @computer = computers(:one)
  end

  test "visiting the index" do
    visit computers_url
    assert_selector "h1", text: "Computers"
  end

  test "creating a Computer" do
    visit computers_url
    click_on "New Computer"

    fill_in "Exterior color", with: @computer.exterior_color
    fill_in "Graphics chip", with: @computer.graphics_chip
    fill_in "Manufacturer", with: @computer.manufacturer
    fill_in "Model", with: @computer.model
    fill_in "Processor", with: @computer.processor
    fill_in "Weight", with: @computer.weight
    fill_in "Year started", with: @computer.year_started
    click_on "Create Computer"

    assert_text "Computer was successfully created"
    click_on "Back"
  end

  test "updating a Computer" do
    visit computers_url
    click_on "Edit", match: :first

    fill_in "Exterior color", with: @computer.exterior_color
    fill_in "Graphics chip", with: @computer.graphics_chip
    fill_in "Manufacturer", with: @computer.manufacturer
    fill_in "Model", with: @computer.model
    fill_in "Processor", with: @computer.processor
    fill_in "Weight", with: @computer.weight
    fill_in "Year started", with: @computer.year_started
    click_on "Update Computer"

    assert_text "Computer was successfully updated"
    click_on "Back"
  end

  test "destroying a Computer" do
    visit computers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Computer was successfully destroyed"
  end
end
