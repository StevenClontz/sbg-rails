class GradeSpecification < ApplicationRecord
  belongs_to :standard_category, optional: true
  belongs_to :course

  REQUIREMENT_HASH = {
    "satisfactories" =>
      "Total #{Attempt::MARK_HASH['satisfactory']}s",
    "standards_with_one_satisfactory_in_category" =>
      "Standards in category with least one #{Attempt::MARK_HASH['satisfactory']}"
  }
  REQUIREMENT_ARRAY = REQUIREMENT_HASH.invert.to_a

  validates_inclusion_of :requirement, in: REQUIREMENT_HASH.values

  GRADE_HASH = {
    "A" =>
      "A",
    "B" =>
      "B",
    "C" =>
      "C",
    "D" =>
      "D"
  }
  GRADE_ARRAY = GRADE_HASH.invert.to_a

  validates_inclusion_of :grade, in: GRADE_HASH.values

  def requirement
    REQUIREMENT_HASH[self[:requirement]]
  end
end
