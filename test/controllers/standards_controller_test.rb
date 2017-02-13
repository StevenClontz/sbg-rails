require 'test_helper'

class StandardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @standard = standards(:one)
  end

  test "should get index" do
    get standards_url
    assert_response :success
  end

  test "should get new" do
    get new_standard_url
    assert_response :success
  end

  test "should create standard" do
    assert_difference('Standard.count') do
      post standards_url, params: { standard: { description: @standard.description, name: @standard.name } }
    end

    assert_redirected_to standard_url(Standard.last)
  end

  test "should show standard" do
    get standard_url(@standard)
    assert_response :success
  end

  test "should get edit" do
    get edit_standard_url(@standard)
    assert_response :success
  end

  test "should update standard" do
    patch standard_url(@standard), params: { standard: { description: @standard.description, name: @standard.name } }
    assert_redirected_to standard_url(@standard)
  end

  test "should destroy standard" do
    assert_difference('Standard.count', -1) do
      delete standard_url(@standard)
    end

    assert_redirected_to standards_url
  end
end
