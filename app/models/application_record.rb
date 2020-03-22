class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def gd_session
    GoogleDrive::Session.from_config("local/gdconfig.json")
  end
end
