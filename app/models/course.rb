class Course < ApplicationRecord
  has_many :students
  has_many :standards, through: :standard_category
  has_many :standard_categories

  def maximum_satisfactory_attempts
    standard_categories.inject(0) do |sum,standard_category|
      sum +
      standard_category.standards.length *
      standard_category.satisfactory_limit
    end
  end
end
