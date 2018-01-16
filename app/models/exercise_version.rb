class ExerciseVersion < ApplicationRecord
  belongs_to :covered_standard
  belongs_to :exercise
end
