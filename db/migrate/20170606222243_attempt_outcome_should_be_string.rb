class AttemptOutcomeShouldBeString < ActiveRecord::Migration[5.0]
  def change
    remove_column :attempts, :outcome_id, :integer
    add_column :attempts, :mark, :string
  end
end
