class Exercise < ApplicationRecord
  belongs_to :standard
  has_one :standard_category, through: :standard
  has_one :course, through: :standard_category
end
