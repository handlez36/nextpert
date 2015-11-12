require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  include FactoryGirl::Syntax::Methods
  # test "the truth" do
  #   assert true
  # end
  test "course index page" do
    get :index
    
    assert_response :success
  end
  
  test "course show single page" do
    
    course = FactoryGirl.create(:course)
    
    get :show, :id => course.id
    
    assert_response :success
  end
  
  test "course show with nonvalid id" do
    get :show, :id => 'wrong'
    
    assert_response :unprocessable_entity
  end
end
