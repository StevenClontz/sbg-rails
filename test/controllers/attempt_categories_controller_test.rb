require 'test_helper'

class AttemptCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attempt_category = attempt_categories(:one)
  end

  test "should get index" do
    get attempt_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_attempt_category_url
    assert_response :success
  end

  test "should create attempt_category" do
    assert_difference('AttemptCategory.count') do
      post attempt_categories_url, params: { attempt_category: { default_attempt_points: @attempt_category.default_attempt_points, name: @attempt_category.name } }
    end

    assert_redirected_to attempt_category_url(AttemptCategory.last)
  end

  test "should show attempt_category" do
    get attempt_category_url(@attempt_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_attempt_category_url(@attempt_category)
    assert_response :success
  end

  test "should update attempt_category" do
    patch attempt_category_url(@attempt_category), params: { attempt_category: { default_attempt_points: @attempt_category.default_attempt_points, name: @attempt_category.name } }
    assert_redirected_to attempt_category_url(@attempt_category)
  end

  test "should destroy attempt_category" do
    assert_difference('AttemptCategory.count', -1) do
      delete attempt_category_url(@attempt_category)
    end

    assert_redirected_to attempt_categories_url
  end
end
