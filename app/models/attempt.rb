class Attempt < ApplicationRecord
  belongs_to :standard
  belongs_to :student
  has_one :course, through: :student

  scope :recent_provisionals, -> { where("attempted_on > ?", Time.now-8.days).where(mark:"provisional") }

  MARK_HASH = {
    "unknown" => "?",
    "unsatisfactory" => "×",
    "satisfactory" => "✓",
    "provisional" => "★",
    "provisional_satisfactory" => "★✓",
    "provisional_unsatisfactory" => "★×"
  }
  MARK_ARRAY = MARK_HASH.invert.to_a

  validates_inclusion_of :mark, in: MARK_HASH.values

  def mark
    MARK_HASH[self[:mark]]
  end
end
