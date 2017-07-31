class Attempt < ApplicationRecord
  belongs_to :standard
  belongs_to :student
  belongs_to :attempt_category
  has_one :course, through: :student

  before_create :set_attempt_points_used_to_default

  MARK_HASH = {
    "unsatisfactory" => "×",
    "incomplete" => "!",
    "provisional" => "★",
    "provisional_unsatisfactory" => "★×",
    "provisional_satisfactory" => "★✓",
    "satisfactory" => "✓",
    "unknown" => "?"
  }
  MARK_ARRAY = MARK_HASH.invert.to_a

  validates_inclusion_of :mark, in: MARK_HASH.values

  def mark
    MARK_HASH[self[:mark]]
  end

  def counts_as_satisfactory?
    ["provisional_satisfactory","satisfactory"].include?(self[:mark])
  end

  private

  def set_attempt_points_used_to_default
    if self.attempt_category && self.attempt_points_used.nil?
      self.attempt_points_used = self.attempt_category.default_attempt_points
    end
  end

end
