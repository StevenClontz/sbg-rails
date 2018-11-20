class Attempt < ApplicationRecord
  belongs_to :standard
  belongs_to :student
  belongs_to :attempt_category
  has_one :course, through: :student

  before_create :set_attempt_points_used_to_default

  default_scope { order(:attempted_on) }

  MARK_HASH = {
    "unsatisfactory" => "✘",
    "incomplete" => "⚠",
    "provisional" => "✱",
    "provisional_unsatisfactory" => "✱⚠",
    "provisional_satisfactory" => "✱✔",
    "satisfactory" => "✔",
    "unknown" => "?"
  }
  MARK_ARRAY = MARK_HASH.invert.to_a

  validates_inclusion_of :mark, in: MARK_HASH.values

  def mark
    MARK_HASH[self[:mark]]
  end

  def mark_tex
    MARK_TEX[self[:mark]]
  end

  def counts_as_satisfactory?
    ["provisional_satisfactory","satisfactory"].include?(self[:mark])
  end

  def self.create_from_gradescope_csv filepath, params, course_id
    CSV.foreach(filepath, headers: true) do |row|
      break if row[0].nil?
      student_id = Student
        .where(school_identifier: row[3], course_id: course_id)
        .pluck(:id).first
      result = "unknown"
      result = "satisfactory" if row[7]=="true"
      result = "provisional" if row[8]=="true"
      result = "incomplete" if row[9]=="true"
      result = "unsatisfactory" if row[10]=="true"
      self.new(params).update_attributes!(
        mark: result, 
        student_id: student_id,
        note: "imported from Gradescope"
      )
    end
  end    

  private

  def set_attempt_points_used_to_default
    if self.attempt_category && self.attempt_points_used.nil?
      self.attempt_points_used = self.attempt_category.default_attempt_points
    end
  end

end
