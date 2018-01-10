class AssessmentsBelongToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :assessments, :course_id, :integer
    add_index :assessments, [:assessment_id, :standard_id]
  end
end
