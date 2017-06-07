class Attempt < ApplicationRecord
  belongs_to :standard
  belongs_to :student
  has_one :course, through: :student

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
