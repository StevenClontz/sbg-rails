require 'test_helper'

class GradeSpecificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grade_specification = grade_specifications(:one)
  end

  test "should get index" do
    get grade_specifications_url
    assert_response :success
  end

  test "should get new" do
    get new_grade_specification_url
    assert_response :success
  end

  test "should create grade_specification" do
    assert_difference('GradeSpecification.count') do
      post grade_specifications_url, params: { grade_specification: { amount: @grade_specification.amount, grade: @grade_specification.grade, requirement: @grade_specification.requirement, standard_category_id: @grade_specification.standard_category_id } }
    end

    assert_redirected_to grade_specification_url(GradeSpecification.last)
  end

  test "should show grade_specification" do
    get grade_specification_url(@grade_specification)
    assert_response :success
  end

  test "should get edit" do
    get edit_grade_specification_url(@grade_specification)
    assert_response :success
  end

  test "should update grade_specification" do
    patch grade_specification_url(@grade_specification), params: { grade_specification: { amount: @grade_specification.amount, grade: @grade_specification.grade, requirement: @grade_specification.requirement, standard_category_id: @grade_specification.standard_category_id } }
    assert_redirected_to grade_specification_url(@grade_specification)
  end

  test "should destroy grade_specification" do
    assert_difference('GradeSpecification.count', -1) do
      delete grade_specification_url(@grade_specification)
    end

    assert_redirected_to grade_specifications_url
  end
end
