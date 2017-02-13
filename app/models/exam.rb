class Exam < ApplicationRecord
  has_many :assessments
  has_many :standards, through: :assessments
end
