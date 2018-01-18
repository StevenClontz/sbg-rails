class CoveredStandard < ApplicationRecord
  belongs_to :assessment
  belongs_to :standard
  has_many :exercise_versions, dependent: :destroy
  has_many :exercises, through: :exercise_versions

  def name
    standard.name
  end
end
