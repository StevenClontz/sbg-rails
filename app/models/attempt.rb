class Attempt < ApplicationRecord
  belongs_to :assessment
  belongs_to :student

  OUTCOME_LABELS = {
    -2 => "?",
    -1 => "×",
     0 => "★",
     1 => "✓"
  }
  OUTCOME_ARRAY = OUTCOME_LABELS.invert.to_a

  validates_inclusion_of :outcome_id, in: OUTCOME_LABELS.keys

  def outcome
    OUTCOME_LABELS[outcome_id]
  end
end
