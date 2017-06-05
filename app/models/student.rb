class Student < ApplicationRecord
  belongs_to :course
  has_many :attempts

  def name
    "#{last_name}, #{first_name}"
  end
end
