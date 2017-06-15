class AttemptCategory < ApplicationRecord
  belongs_to :course
  has_many :attempts
end
