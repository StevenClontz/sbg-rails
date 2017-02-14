class AttemptsBelongToAssessmentAndStudent < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :attempts, :assessment
    add_belongs_to :attempts, :student
  end
end
