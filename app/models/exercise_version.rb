class ExerciseVersion < ApplicationRecord
  belongs_to :covered_standard
  belongs_to :exercise
  has_many :version_assignments, dependent: :destroy
  has_many :students, through: :version_assignments
end
