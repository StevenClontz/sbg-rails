class AddAttemptedOnToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :attempted_on, :datetime
  end
end
