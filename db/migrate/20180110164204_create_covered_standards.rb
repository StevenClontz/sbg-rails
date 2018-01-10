class CreateCoveredStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :covered_standards do |t|

      t.timestamps
    end
  end
end
