class Student < ApplicationRecord
  has_many :attempts
  has_many :assessments, through: :attempts
  has_many :standards, through: :assessments
  has_many :exams, through: :assessments

  def name
    "#{last_name}, #{first_name}"
  end

  def deciding_attempt assessment
    if (attempts = Attempt.where student: self, assessment: assessment).length > 0
      attempts.last
    else
      Attempt.new student_id: id, outcome_id: -2
    end
  end

  def count_successful_attempts standard
    count = 0
    standard.assessments.each do |assessment|
      count+=1 if deciding_attempt(assessment).outcome_id == 1
    end
    [count,standard.category].min
  end
end
