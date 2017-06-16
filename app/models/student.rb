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
      standard.satisfactory_limit
    ].min
  end

  def count_satisfactories
    course.standards.inject(0) do |sum,standard|
      sum + count_satisfactories_for_standard(standard)
    end
  end

  def count_standards_with_one_satisfactory_in_category standard_category
    attempts.select{|a|
      a.standard.standard_category_id==standard_category.id &&
      a[:mark]=="satisfactory"
    }.map{|a|a.standard}.compact.count
  end
end
