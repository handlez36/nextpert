class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course
  
  def new
    @section = Section.new
  end
  
  def create
    @section = current_course.sections.create(section_params)
    
    if @section.valid?
      redirect_to instructor_course_path(current_course)
    else
      render :new, :status => :unprocessable_entity
    end
    
  end
  
  private
  
  def require_authorized_for_current_course
    puts "Current user: #{current_user.inspect}"
    puts "Current Course user: #{current_course.user.inspect}"
    if current_user != current_course.user
      return render :text => "Unauthorized User", :status => :unauthorized
    end
  end
  
  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end
  
  def section_params
    params.require(:section).permit(:title)
  end
  
end
