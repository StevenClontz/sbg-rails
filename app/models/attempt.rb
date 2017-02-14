class Attempt < ApplicationRecord
  belongs_to :assessment
  belongs_to :student

  OUTCOMES = [
    ["?",-2],
    ["×",-1],
    ["★",0],
    ["✓",1]
  ]

  validates_inclusion_of :outcome_id, in: OUTCOMES.collect{|a|a[1]}

  def outcome
    OUTCOMES.to_h.invert[outcome_id]
  end
end
