class CreateStandardCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :standard_categories do |t|
      t.string :name
      t.string :description
      t.integer :satsifactory_limit

      t.timestamps
    end
    add_reference :standards, :category, foreign_key: true
  end
end
