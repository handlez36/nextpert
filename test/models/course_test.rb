require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  
  test "Next Lesson" do
    course = create(:course)
    section1 = create(:section, :course => course)
    lesson1 = create(:lesson, :section => section1)
    lesson2 = create(:lesson, :section => section1)
    lesson3 = create(:lesson, :section => section1)

    section2 = create(:section, :course => course)
    lesson4 = create(:lesson, :section => section2)

    assert_equal( lesson3.id, lesson2.next_lesson.id)
    assert_equal( lesson4.id, lesson3.next_lesson.id)
     
   end
end
