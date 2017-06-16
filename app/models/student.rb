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
    satisfactories = attempts
      .select{|a|
        a.standard_id==standard.id &&
        a[:mark]=="satisfactory"
      }.length
    provisional_satisfactories = attempts
      .select{|a|
        a.standard_id==standard.id &&
        a[:mark]=="provisional_satisfactory"
      }.length
    [
      satisfactories + provisional_satisfactories,
      standard.satsifactory_limit
    ].min
  end
end
