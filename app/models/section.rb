class Section < ApplicationRecord
  belongs_to :course
  has_many :students

  def sync_progress_to_gd
    students.each do |s|
      sleep 5.seconds # to avoid timeouts
      s.create_gd_sheet
      s.save_gd_sheet
    end
  end
end
