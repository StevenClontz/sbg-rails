class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end
