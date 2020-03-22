class AddGoogleDriveFields < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :gd_folder, :string
    add_column :students, :gd_sheet, :string
  end
end
