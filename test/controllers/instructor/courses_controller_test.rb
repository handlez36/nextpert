require 'test_helper'

class Instructor::CoursesControllerTest < ActionController::TestCase
  include FactoryGirl::Syntax::Methods
  
  test "instructor new course creation - logged out" do
    post :create, :course => create(:course)
    assert_redirected_to new_user_session_path
  end

  
  test "instructor new course creation - logged in" do
    user = create(:user)
    sign_in user
    
    # Create 
    dummy_course = create(:course)
    
    assert_difference "user.courses.count" do
      post :create, :course => {
        title: "Test",
        description: "Test description",
        cost: 300.00
      }
      
    end
    
    assert_redirected_to instructor_course_path(Course.last)
  end
  
  test "instructor new course - invalid params" do
    sign_in create(:user)
    
    post :create, :course => {
      title: "Test",
      description: "Wrong param description",
      cost: "wrong"
    }
    
    assert_response :unprocessable_entity
  end
  
  
end
