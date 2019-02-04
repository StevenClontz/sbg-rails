class Assessment < ApplicationRecord
  has_many :covered_standards, dependent: :destroy
  has_many :standards, through: :covered_standards
  belongs_to :course

  def assign_exercises_to_students(number_of_versions=4)
    covered_standards.each do |covered_standard|
      exercises = Exercise.where(
        standard_id: covered_standard.standard_id
      ).order("RANDOM()").limit(number_of_versions)
      if exercises.length > 0
        course_student_ids = course.student_ids
        student_ids_slices = course_student_ids
          .shuffle
          .each_slice(
            (course_student_ids.length + exercises.length - 1) / exercises.length
          )
          .to_a
        exercises.each_with_index do |exercise,index|
          ExerciseVersion.create(
            exercise_id: exercise.id,
            covered_standard_id: covered_standard.id,
            student_ids: student_ids_slices[index]
          )
        end
      end
    end
  end
end
