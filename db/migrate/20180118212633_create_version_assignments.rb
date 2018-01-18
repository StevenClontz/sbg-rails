class CreateVersionAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :version_assignments do |t|

      t.timestamps
    end
  end
end
