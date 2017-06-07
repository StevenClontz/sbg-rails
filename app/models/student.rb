class Student < ApplicationRecord
  belongs_to :course
  has_many :attempts

  def name
    "#{last_name}, #{first_name}"
  end

  def count_satisfactories_for_standard standard
    sats = attempts.where(standard:standard,mark:"satisfactory").count
    prov_sats = attempts.where(standard:standard,mark:"provisional_satisfactory").count
    [sats+prov_sats,2].min
  end
end
