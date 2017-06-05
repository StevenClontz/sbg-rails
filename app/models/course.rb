class Course < ApplicationRecord
  has_many :students
  has_many :standards
end
