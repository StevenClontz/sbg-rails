class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  creds = File.readlines('local/password.txt').map(&:strip)
  http_basic_authenticate_with name: creds[0], password: creds[1]

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end
