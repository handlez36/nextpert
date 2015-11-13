class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_current_user_has_access
  
  def show
  end
  
  private
  
  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
  
  def validate_current_user_has_access
    #current_user.enrolled_courses.include? current_lesson.course
    puts "In Validate..."
    if !current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), :alert => "You must first enroll to view lesson details"
    end
  end
end
