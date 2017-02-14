class Student < ApplicationRecord
  has_many :attempts
  has_many :assessments, through: :attempts
  has_many :standards, through: :assessments
  has_many :exams, through: :assessments

  def name
    "#{last_name}, #{first_name}"
  end
end
