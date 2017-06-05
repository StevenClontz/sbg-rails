class StudentsAndStandardsBelongToCourses < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :students, :course
    add_belongs_to :standards, :course
  end
end
