require 'test_helper'

class StandardCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @standard_category = standard_categories(:one)
  end

  test "should get index" do
    get standard_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_standard_category_url
    assert_response :success
  end

  test "should create standard_category" do
    assert_difference('StandardCategory.count') do
      post standard_categories_url, params: { standard_category: { description: @standard_category.description, name: @standard_category.name, satsifactory_limit: @standard_category.satsifactory_limit } }
    end

    assert_redirected_to standard_category_url(StandardCategory.last)
  end

  test "should show standard_category" do
    get standard_category_url(@standard_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_standard_category_url(@standard_category)
    assert_response :success
  end

  test "should update standard_category" do
    patch standard_category_url(@standard_category), params: { standard_category: { description: @standard_category.description, name: @standard_category.name, satsifactory_limit: @standard_category.satsifactory_limit } }
    assert_redirected_to standard_category_url(@standard_category)
  end

  test "should destroy standard_category" do
    assert_difference('StandardCategory.count', -1) do
      delete standard_category_url(@standard_category)
    end

    assert_redirected_to standard_categories_url
  end
end
