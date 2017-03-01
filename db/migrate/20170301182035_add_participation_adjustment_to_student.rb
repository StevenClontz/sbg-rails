class AddParticipationAdjustmentToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :participation_adjustment, :integer
  end
end
