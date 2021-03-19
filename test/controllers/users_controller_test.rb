require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, favorite_ice_cream: @user.favorite_ice_cream, favorite_pizza: @user.favorite_pizza, favorite_sandwich: @user.favorite_sandwich, first_name: @user.first_name, last_name: @user.last_name, middle_name: @user.middle_name, pet_count: @user.pet_count, pet_name: @user.pet_name } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, favorite_ice_cream: @user.favorite_ice_cream, favorite_pizza: @user.favorite_pizza, favorite_sandwich: @user.favorite_sandwich, first_name: @user.first_name, last_name: @user.last_name, middle_name: @user.middle_name, pet_count: @user.pet_count, pet_name: @user.pet_name } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
