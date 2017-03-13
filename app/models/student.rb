class Student < ApplicationRecord
  has_many :attempts
  has_many :assessments, through: :attempts
  has_many :standards, through: :assessments
  has_many :exams, through: :assessments

  def name
    "#{last_name}, #{first_name}"
  end

  def decisive_attempt assessment
    if (attempts =
      Attempt.where student: self, assessment: assessment
    ).length > 0
      attempts.last
    else
      Attempt.new student_id: id, outcome_id: -2
    end
  end

  def count_successful_attempts standard
    count = standard.assessments.map{|a|decisive_attempt(a)}
                                .count{|a|a.outcome_id==1}
    [count,standard.category].min
  end

  def participation_average
    ((irq_grade||0)+(trq_grade||0)+(pes_grade||0)+2)/3
  end

  def participation_grade
    participation_average+participation_adjustment
  end

  def core_single_success_count
    Standard
        .where(category:2).to_a
        .count{|s|count_successful_attempts(s) >= 1}
  end

  def core_double_success_count
    Standard
        .where(category:2).to_a
        .count{|s|count_successful_attempts(s) >= 2}
  end

  def supplemental_single_success_count
    Standard
        .where(category:1).to_a
        .count{|s|count_successful_attempts(s) >= 1}
  end

  def midsemester_grade
    if    (core_single_success_count>=6) &&
          (core_double_success_count>=4) &&
          (supplemental_single_success_count>=5) &&
          (participation_grade>=80)
      "A"
    elsif (core_single_success_count>=5) &&
          (core_double_success_count>=3) &&
          (supplemental_single_success_count>=4) &&
          (participation_grade>=70)
      "B"
    elsif (core_single_success_count>=4) &&
          (core_double_success_count>=2) &&
          (supplemental_single_success_count>=3) &&
          (participation_grade>=60)
      "C"
    elsif (core_single_success_count>=3)
      "D"
    else
      "F"
    end
  end

  def semester_grade
    if    (core_single_success_count>=16) &&
          (core_double_success_count>=13) &&
          (supplemental_single_success_count>=13) &&
          (participation_grade>=80)
      "A"
    elsif (core_single_success_count>=14) &&
          (core_double_success_count>=10) &&
          (supplemental_single_success_count>=10) &&
          (participation_grade>=70)
      "B"
    elsif (core_single_success_count>=12) &&
          (core_double_success_count>=8) &&
          (supplemental_single_success_count>=8) &&
          (participation_grade>=60)
      "C"
    elsif (core_single_success_count>=10)
      "D"
    else
      "F"
    end
  end
end
