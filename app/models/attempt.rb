class Attempt < ApplicationRecord
  belongs_to :standard
  belongs_to :student
  belongs_to :attempt_category
  has_one :course, through: :student

  before_create :set_attempt_points_used_to_default

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

  def self.create_from_gradescope_csv(file,attempt_category_id,standard_id,date)
    CSV.foreach(file.path, headers: true) do |row|
      break if row[0].nil?
      student_id = Student.where(school_identifier: row[2]).pluck(:id).first
      result = "unknown"
      result = "satisfactory" if row[5]=="true"
      result = "provisional" if row[6]=="true"
      result = "incomplete" if row[7]=="true"
      result = "unsatisfactory" if row[8]=="true"
      self.create(
        attempt_category_id: attempt_category_id,
        standard_id: standard_id, 
        attempted_on: date, 
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
