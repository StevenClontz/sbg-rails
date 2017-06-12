class Student < ApplicationRecord
  belongs_to :course
  has_many :attempts

  default_scope do
    order(last_name: :asc, first_name: :asc)
  end

  def name
    "#{last_name}, #{first_name}"
  end

  def count_satisfactories_for_standard standard
    sats = attempts.where(standard:standard,mark:"satisfactory").count
    prov_sats = attempts.where(standard:standard,mark:"provisional_satisfactory").count
    [sats+prov_sats,standard.standard_category.satsifactory_limit].min
  end
end
