class AddTypeToStandard < ActiveRecord::Migration[5.0]
  def change
    add_column :standards, :type, :integer
  end
end
