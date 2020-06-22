require 'test_helper'

class CalleesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @callee = callees(:one)
  end

  test "should get index" do
    get callees_url
    assert_response :success
  end

  test "should get new" do
    get new_callee_url
    assert_response :success
  end

  test "should create callee" do
    assert_difference('Callee.count') do
      post callees_url, params: { callee: { bio: @callee.bio, first_name: @callee.first_name, last_name: @callee.last_name } }
    end

    assert_redirected_to callee_url(Callee.last)
  end

  test "should show callee" do
    get callee_url(@callee)
    assert_response :success
  end

  test "should get edit" do
    get edit_callee_url(@callee)
    assert_response :success
  end

  test "should update callee" do
    patch callee_url(@callee), params: { callee: { bio: @callee.bio, first_name: @callee.first_name, last_name: @callee.last_name } }
    assert_redirected_to callee_url(@callee)
  end

  test "should destroy callee" do
    assert_difference('Callee.count', -1) do
      delete callee_url(@callee)
    end

    assert_redirected_to callees_url
  end
end
