class Exercise < ApplicationRecord
  belongs_to :standard
  has_one :standard_category, through: :standard
  has_one :course, through: :standard_category

  def self.create_from_csv filepath, course_id
    CSV.foreach(filepath) do |row|
      next if row[0].nil?
      possible_standards = Standard.where(name:row[0]).select{|s| s.course.id==course_id}
      if possible_standards.length > 0
        standard_id = possible_standards[0].id
      else
        standard_id = row[0]
      end
      self.create(
        standard_id: standard_id, 
        description: row[1],
        solution: row[2] 
      )
    end
  end    
end
