class ConnectCoveredStandardsAndExerciseVersions < ActiveRecord::Migration[5.0]
  def change
    add_column :exercise_versions, :covered_standard_id, :integer
    add_column :exercise_versions, :exercise_id, :integer
    add_index :exercise_versions, [:covered_standard_id, :exercise_id]
  end
end
