class Lesson < ActiveRecord::Base
  belongs_to :section
  mount_uploader :video, VideoUploader
  
  include RankedModel
  ranks :row_order, :with_same => :section_id
  
  def next_lesson
    lesson = section.lessons.where("row_order > ?", self.row_order).rank(:row_order).first    
    
    if lesson.blank? && section.next_section
      return section.next_section.lessons.rank(:row_order).first
    end
    
    return lesson
  end
  
  def next_section
    current_section = self.section
    current_course = current_section.course
    
    section = current_course.sections.where("row_order > ?", current_section.row_order).rank(:row_order).first
  end
end
