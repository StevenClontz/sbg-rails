class ConnectExercisesVersionsAndStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :version_assignments, :exercise_version_id, :integer
    add_column :version_assignments, :student_id, :integer
    add_index :version_assignments, [:exercise_version_id, :student_id], name: 'index__version_assignment__exercise_version__student'
  end
end
