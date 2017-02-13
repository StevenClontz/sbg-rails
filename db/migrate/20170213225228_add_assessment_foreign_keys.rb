class AddAssessmentForeignKeys < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :assessments, :standard
    add_belongs_to :assessments, :exam
  end
end
