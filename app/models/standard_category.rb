class StandardCategory < ApplicationRecord
  belongs_to :course
  has_many :standards
end
