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

  def progress_matrix
    matrix = []
    matrix << ["Updated on:", DateTime.now.strftime("%Y-%m-%d")]
    matrix << ["Progress Report", name, email]
    course.standard_categories.each do |sc|
      matrix << sc.standards.map(&:name)
      matrix << sc.standards.map{|st| count_satisfactories_for_standard(st)}
    end
    matrix << ["Total Mastery Checkmarks:", count_satisfactories]
    matrix << ["Attempt History:"]
    attempts.each do |a|
      matrix << [a.standard.name, a.attempted_on.strftime("%Y-%m-%d"), a.mark]
    end
    matrix
  end

  def create_gd_sheet
    if gd_sheet.blank?
      session = gd_session
      spreadsheet = session.create_spreadsheet("#{name} progress for #{course.name}")
      session.collection_by_id(course.gd_folder).add(spreadsheet)
      update!(gd_sheet: spreadsheet.id)
    end
  end

  def save_gd_sheet
    spreadsheet = gd_session.spreadsheet_by_key(gd_sheet)
    ws = spreadsheet.add_worksheet("Progress (#{DateTime.now.to_s})")
    ws.update_cells(1,1,progress_matrix)
    ws.save
    spreadsheet.worksheets[0].delete
  end

  def self.to_csv
    student_attrs = %w{id name school_identifier email}
    attempt_attrs = %w(attempt_category_id attempt_category standard_id standard attempted_on mark)
    CSV.generate(headers: true) do |csv|
      csv << (student_attrs + attempt_attrs)
      all.each do |student|
        student.attempts.each do |attempt|
          csv << student_attrs.map{|attr| student.send(attr)} + [
            attempt.attempt_category_id,
            attempt.attempt_category.name,
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
