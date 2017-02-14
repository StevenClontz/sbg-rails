class ChangeResultToAttempt < ActiveRecord::Migration[5.0]
  def change
    rename_table :results, :attempts
  end
end
