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

  def create_exercises_from_mastr filepath
    seeds = (20..99).to_a.sample(20)
    exercises = []
    seeds.each do |seed|
      source = File.readlines(filepath + "/0" + seed.to_s + ".tex")
      state = :waiting
      source.each do |line|
        case state
        when :waiting
          if line.strip.start_with? '\begin{exerciseStatement}'
            state = :statement
            exercises << Exercise.new(standard_id: id, description: '', solution: '')
          elsif line.strip.start_with? '\begin{exerciseAnswer}'
            state = :answer
          end
        when :statement
          if line.strip.start_with? '\end{exerciseStatement}'
            state = :waiting
          else
            exercises[-1].description << line
          end
        when :answer
          if line.strip.start_with? '\end{exerciseAnswer}'
            state = :waiting
          else
            exercises[-1].solution << line
          end
        end
      end
      exercises.each(&:save)
    end
  end
end
