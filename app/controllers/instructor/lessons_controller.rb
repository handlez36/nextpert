class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, :only => [:create]
  before_action :require_authorized_for_current_lesson, :only => [:update]
  
  def create
    @lesson = current_section.lessons.create(lesson_params)
    
    if @lesson.valid?
      redirect_to instructor_course_path(current_section.course)
    else
      render :new, :status => :unprocessable_entity
    end
  end
  
  def update
    current_lesson.update_attributes(lesson_params)
    render :text => "updated!"
  end
  
  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find_by_id(params[:id])
  end
  
  def require_authorized_for_current_section
    if current_user != current_section.course.user
      render :text => "Unauthorized User", :status => :unauthorized
    end
  end
  
  def require_authorized_for_current_lesson
    if current_user != current_lesson.section.course.user
      render :text => "Unauthorized User", :status => :unauthorized
    end
  end
  
  helper_method :current_section
  def current_section
    @current_section ||= Section.find(params[:section_id])
  end
  
  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video, :row_order_position)
  end
end
