require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Email", with: @user.email
    fill_in "Favorite ice cream", with: @user.favorite_ice_cream
    fill_in "Favorite pizza", with: @user.favorite_pizza
    fill_in "Favorite sandwich", with: @user.favorite_sandwich
    fill_in "First name", with: @user.first_name
    fill_in "Last name", with: @user.last_name
    fill_in "Middle name", with: @user.middle_name
    fill_in "Pet count", with: @user.pet_count
    fill_in "Pet name", with: @user.pet_name
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Email", with: @user.email
    fill_in "Favorite ice cream", with: @user.favorite_ice_cream
    fill_in "Favorite pizza", with: @user.favorite_pizza
    fill_in "Favorite sandwich", with: @user.favorite_sandwich
    fill_in "First name", with: @user.first_name
    fill_in "Last name", with: @user.last_name
    fill_in "Middle name", with: @user.middle_name
    fill_in "Pet count", with: @user.pet_count
    fill_in "Pet name", with: @user.pet_name
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
