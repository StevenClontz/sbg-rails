class Standard < ApplicationRecord
  belongs_to :standard_category
  has_one :course, through: :standard_category
  has_many :attempts
  has_many :covered_standards, dependent: :destroy
  has_many :assessments, through: :covered_standards
  has_many :exercises

  default_scope do
    order(:standard_category_id, :name)
  end

  def satisfactory_limit
    standard_category.satisfactory_limit
  end

  def success_index
    students = Student.includes(:attempts).where(course:course)
    successes = students
      .map{|s|s.count_satisfactories_for_standard(self)}
      .reduce(:+)
    successes.to_f / students.length
  end
end
