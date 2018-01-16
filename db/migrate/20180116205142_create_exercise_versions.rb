class CreateExerciseVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :exercise_versions do |t|

      t.timestamps
    end
  end
end
