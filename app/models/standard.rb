class Standard < ApplicationRecord
  belongs_to :standard_category
  has_one :course, through: :standard_category
  has_many :attempts
  has_many :covered_standards, dependent: :destroy
  has_many :assessments, through: :covered_standards
  has_many :exercises

  default_scope do
    order(:standard_category_id, :id)
  end

  def satisfactory_limit
    standard_category.satisfactory_limit
  end

  def unmastered_by_student? student
    student.count_satisfactories_for_standard(self) < satisfactory_limit
  end

  def success_index
    students = Student.includes(:attempts).where(course:course)
    successes = students
      .map{|s|s.count_satisfactories_for_standard(self)}
      .reduce(:+)
    successes.to_f / students.length
  end

  def create_exercises_from_file filepath
    source = File.readlines filepath
    exercises = []
    state = :waiting
    source.each do |line|
      case state
      when :waiting
        if line.start_with? '\begin{problem}'
          state = :problem
          exercises << Exercise.new(standard_id: id, description: '', solution: '')
        elsif line.start_with? '\begin{solution}'
          state = :solution
        end
      when :problem
        if line.start_with? '\end{problem}'
          state = :waiting
        else
          exercises[-1].description << line
        end
      when :solution
        if line.start_with? '\end{solution}'
          state = :waiting
        else
          exercises[-1].solution << line
        end
      end
    end
    exercises.each(&:save)
  end
end
