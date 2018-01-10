class ConnectAssessmentsAndStandards < ActiveRecord::Migration[5.0]
  def change
    add_column :covered_standards, :assessment_id, :integer
    add_column :covered_standards, :standard_id, :integer
    add_index :covered_standards, [:assessment_id, :standard_id]
  end
end
