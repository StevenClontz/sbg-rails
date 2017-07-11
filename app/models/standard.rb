class Standard < ApplicationRecord
  belongs_to :standard_category
  has_one :course, through: :standard_category
  has_many :attempts

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
