class Standard < ApplicationRecord
  has_many :assessments
  has_many :exams, through: :assessments
end
