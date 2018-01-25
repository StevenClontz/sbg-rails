class AddTexHeaderToAssessment < ActiveRecord::Migration[5.0]
  def change
    add_column :assessments, :tex_header, :text
  end
end
