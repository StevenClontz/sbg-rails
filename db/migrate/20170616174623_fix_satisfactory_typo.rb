class FixSatisfactoryTypo < ActiveRecord::Migration[5.0]
  def change
    rename_column :standard_categories, :satsifactory_limit, :satisfactory_limit
  end
end
