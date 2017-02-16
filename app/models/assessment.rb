class Assessment < ApplicationRecord
  belongs_to :standard
  belongs_to :exam
  has_many :attempts

  def exam_standard
    "#{exam.name}, #{standard.name}"
  end

  def success_count
    Student.all.map{|s|s.decisive_attempt(self).outcome_id}.count{|id|id==1}
  end
end
