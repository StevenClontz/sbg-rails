class Attempt < ApplicationRecord
  belongs_to :assessment
  belongs_to :student
end
