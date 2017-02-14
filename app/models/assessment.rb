class Assessment < ApplicationRecord
  belongs_to :standard
  belongs_to :exam
  has_many :attempts

  def exam_standard
    "#{exam.name}, #{standard.name}"
  end
end
