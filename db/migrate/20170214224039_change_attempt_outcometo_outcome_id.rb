class ChangeAttemptOutcometoOutcomeId < ActiveRecord::Migration[5.0]
  def change
    rename_column :attempts, :outcome, :outcome_id
  end
end
