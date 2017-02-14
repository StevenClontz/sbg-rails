class Assessment < ApplicationRecord
  belongs_to :standard
  belongs_to :exam
  has_many :attempts
end
