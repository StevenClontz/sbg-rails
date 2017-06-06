class Attempt < ApplicationRecord
  belongs_to :standard
  belongs_to :student
  has_one :course, through: :student

  MARK_LABELS = {
    "unknown" => "?",
    "unsatisfactory" => "×",
    "satisfactory" => "✓",
    "provisional" => "★",
    "provisional_satisfactory" => "★✓",
    "provisional_unsatisfactory" => "★×"
  }
  MARK_ARRAY = MARK_LABELS.invert.to_a

  validates_inclusion_of :mark, in: MARK_LABELS.values

  def mark
    MARK_LABELS[self[:mark]]
  end
end
