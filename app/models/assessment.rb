class Assessment < ApplicationRecord
  has_many :covered_standards, dependent: :destroy
  has_many :standards, through: :covered_standards
  belongs_to :course
end
