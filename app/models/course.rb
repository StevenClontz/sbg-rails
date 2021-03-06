class Course < ApplicationRecord
  has_many :students
  has_many :sections
  has_many :standard_categories
  has_many :standards, through: :standard_categories
  has_many :grade_specifications
  has_many :attempt_categories
  has_many :attempts, through: :students

  def maximum_satisfactory_attempts
    standard_categories.inject(0) do |sum,standard_category|
      sum +
      standard_category.standards.length *
      standard_category.satisfactory_limit
    end
  end

  def students_by_name
    students.reorder(:last_name,:first_name)
  end

  def report_attempts_on_date date_string
    all_attempts = attempts.where("DATE(attempted_on) = ?", date_string)
    satisfactory_count = all_attempts.where(mark: "satisfactory").count
    provisional_count = all_attempts.where(mark:[
       "provisional",
       "provisional_unsatisfactory",
       "provisional_satisfactory"
      ]).count
    "#{all_attempts.count} attempts, #{satisfactory_count} ✔s, #{provisional_count} ✱s"
  end

  def create_gd_folder
    session = GoogleDrive::Session.from_config("local/gdconfig.json")
    if gd_folder.blank?
      update!(gd_folder: session.create_collection("Grades for #{name}").id)
    end
  end

  def sync_progress_to_gd
    create_gd_folder
    sections.each(&:sync_progress_to_gd)
  end
end
