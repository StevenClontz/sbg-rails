class Course < ApplicationRecord
  has_many :students
  has_many :standards, through: :standard_categories
  has_many :standard_categories
  has_many :grade_specifications
  has_many :attempt_categories

  def maximum_satisfactory_attempts
    standard_categories.inject(0) do |sum,standard_category|
      sum +
      standard_category.standards.length *
      standard_category.satisfactory_limit
    end
  end

  def students_by_name
    students.reorder(:last_name,:first_name)
  end
end
