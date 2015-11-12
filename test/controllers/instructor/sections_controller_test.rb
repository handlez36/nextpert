require 'test_helper'

class Instructor::SectionsControllerTest < ActionController::TestCase
  include FactoryGirl::Syntax::Methods
  
  test "create session with course admin" do
    course = create(:course)
    sign_in course.user
    
    assert_difference "course.sections.count" do
      post :create, :course_id => course.id, :section => {
        title: "New Section"
      }
    
      assert_redirected_to instructor_course_path(course)
    end
  end
  
  test "create session with different user" do
    user = create(:user)
    sign_in user
    
    course = create(:course)
    
    assert_no_difference "course.sections.count" do
      post :create, :course_id => course.id, :section => {
        title: "Shouldn't be able to add"  
      }
    end
    
    assert_response :unauthorized
  end
  
  test "create session with no title" do
    user = create(:user)
    sign_in user
    
    course = create(:course, :user => user)
    
    assert_no_difference "course.sections.count" do
      post :create, :course_id => course.id, :section => {
        title: ""  
      }
    end
    
    assert_response :unprocessable_entity
  end
  
end
