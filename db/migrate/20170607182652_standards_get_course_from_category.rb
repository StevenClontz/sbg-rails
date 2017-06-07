class StandardsGetCourseFromCategory < ActiveRecord::Migration[5.0]
  def change
    remove_reference :standards, :course, foreign_key: true
  end
end
