class Standard < ApplicationRecord
  belongs_to :standard_category
  has_one :course, through: :standard_category
  has_many :attempts

  def satsifactory_limit
    standard_category.satsifactory_limit
  end
end
