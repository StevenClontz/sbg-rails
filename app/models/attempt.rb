class Attempt < ApplicationRecord
  belongs_to :standard
  belongs_to :student
  belongs_to :attempt_category
  has_one :course, through: :student

  before_create :set_attempt_points_used_to_default

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

  private

  def set_attempt_points_used_to_default
    if self.attempt_category && self.attempt_points_used.nil?
      self.attempt_points_used = self.attempt_category.default_attempt_points
    end
  end

end
