class Student < ApplicationRecord
  belongs_to :course
  belongs_to :section
  has_many :attempts
  has_many :version_assignments, dependent: :destroy
  has_many :exercise_versions, through: :version_assignments

  default_scope do
    includes(:section)
    .order(section_id: :asc, last_name: :asc, first_name: :asc)
  end

  def name
    name = "#{last_name}, #{first_name}"
    if section
      name << " (#{section.name})"
    end
    return name
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

  def count_dates_in_attempt_category attempt_category
    attempts.select{|a|a.attempt_category_id==attempt_category.id}.map{|a|a.attempted_on.to_date}.uniq.count
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

  def self.to_csv
    student_attrs = %w{id name school_identifier email}
    attempt_attrs = %w(standard_id standard attempted_on mark)
    CSV.generate(headers: true) do |csv|
      csv << (student_attrs + attempt_attrs)
      all.each do |student|
        csv << student_attrs.map{|attr| student.send(attr)}
        student.attempts.each do |attempt|
          csv << Array.new(4) + [
            attempt.standard_id,
            attempt.standard.name,
            attempt.attempted_on,
            attempt[:mark]
          ]
        end
      end
    end
  end
end
