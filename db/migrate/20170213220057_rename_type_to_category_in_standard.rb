class RenameTypeToCategoryInStandard < ActiveRecord::Migration[5.0]
  def change
    rename_column :standards, :type, :category
  end
end
