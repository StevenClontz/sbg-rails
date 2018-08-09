class Exercise < ApplicationRecord
  belongs_to :standard
  has_one :standard_category, through: :standard
  has_one :course, through: :standard_category

  def self.create_from_csv filepath
    CSV.foreach(filepath) do |row|
      next if row[0].nil?
      unless standard_id = Standard.where(name: row[0]).pluck(:id).first
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
