class CreateGradeSpecifications < ActiveRecord::Migration[5.0]
  def change
    create_table :grade_specifications do |t|
      t.string :grade
      t.string :requirement
      t.integer :amount
      t.references :standard_category, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
