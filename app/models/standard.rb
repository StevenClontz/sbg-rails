class Standard < ApplicationRecord
  belongs_to :standard_category
  has_one :course, through: :standard_category
  has_many :attempts

  def satisfactory_limit
    standard_category.satisfactory_limit
  end
end
