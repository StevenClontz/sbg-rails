class CoveredStandard < ApplicationRecord
  belongs_to :assessment
  belongs_to :standard
end
