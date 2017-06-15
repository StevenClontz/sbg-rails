class CreateAttemptCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :attempt_categories do |t|
      t.string :name
      t.integer :default_attempt_points

      t.timestamps
    end
    add_reference :attempt_categories, :course, foreign_key: true
    add_reference :attempts, :attempt_category, foreign_key: true
  end
end
