class CoursesController < ApplicationController
  
  def index
    @courses = Course.all
  end
  
  def show
    @course = Course.find_by_id(params[:id])
    
    if @course.nil?
      return render :text => "Invalid parameter", :status => :unprocessable_entity
    end
    
  end
  
end
