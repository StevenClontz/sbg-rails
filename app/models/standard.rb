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
    seeds = (100...200).to_a.sample(20)
    exercises = []
    seeds.each do |seed|
      source = File.read(filepath + "/" + seed.to_s + ".tex")
      exercise = Exercise.new(standard_id: id)
      exercise.description = source.split('\begin{exerciseStatement}').last.split('\end{exerciseStatement}').first
      exercise.solution = source.split('\begin{exerciseAnswer}').last.split('\end{exerciseAnswer}').first
      exercise.save
    end
  end
end
