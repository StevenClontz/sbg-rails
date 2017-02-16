class Standard < ApplicationRecord
  has_many :assessments
  has_many :exams, through: :assessments

  def self.all_assessed
    joins(:assessments).group(:id)
  end
end
