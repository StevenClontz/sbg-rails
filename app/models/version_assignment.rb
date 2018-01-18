class VersionAssignment < ApplicationRecord
  belongs_to :exercise_version
  belongs_to :student
end
