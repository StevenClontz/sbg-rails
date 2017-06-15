class AddAttemptPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :uses_attempt_points, :boolean, default: false
    add_column :students, :attempt_points_earned, :integer
    add_column :attempts, :attempt_points_used, :integer
  end
end
