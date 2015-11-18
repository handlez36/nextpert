class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, :only => [:new, :create]
  before_action :require_authorized_for_current_section, :only => [:update]
  
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
  
  def update
    puts "In section update..."
    current_section.update_attributes(section_params)
    render :text => "updated!"
  end
  
  private
  
  def require_authorized_for_current_course
    if current_user != current_course.user
      return render :text => "Unauthorized User", :status => :unauthorized
    end
  end
  
  def require_authorized_for_current_section
    if current_user != current_section.course.user
      return render :text => "Unauthorized User", :status => "unauthorized"
    end
  end
  
  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end
  
  def current_section
    @current_section ||= Section.find_by_id(params[:id])
  end
  
  def section_params
    params.require(:section).permit(:title, :row_order_position)
  end
  
end
