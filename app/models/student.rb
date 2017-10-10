class Student < ApplicationRecord
  belongs_to :course
  belongs_to :section
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
        a.counts_as_satisfactory?
      }.length
    [
      satisfactories,
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
      a.standard.standard_category_id==standard_category.id
    }.select{|a|
      a.counts_as_satisfactory?
    }.map{|a|a.standard}.uniq.count
  end

  def attempt_points_used
    return 0 if attempts.empty?
    attempts.map{|a|a.attempt_points_used || 0}.reduce(:+)
  end
end
