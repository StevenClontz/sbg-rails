class StudentsHaveOneSection < ActiveRecord::Migration[5.0]
  def change
    add_reference :students, :section, foreign_key: true
  end
end
