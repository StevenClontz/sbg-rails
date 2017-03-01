class AddParticipationGradesToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :irq_grade, :integer
    add_column :students, :trq_grade, :integer
    add_column :students, :pes_grade, :integer
  end
end
