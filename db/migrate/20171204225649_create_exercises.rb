class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.text :description
      t.text :solution
      t.belongs_to :standard, foreign_key: true

      t.timestamps
    end
  end
end
