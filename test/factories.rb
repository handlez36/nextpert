FactoryGirl.define do
  factory :user do
    sequence "email" do |n|
      "dummy#{n}@email.com"  
    end
    password "randompassword"
    password_confirmation "randompassword"
  end
end

FactoryGirl.define do
  factory :course do
    title "Test Course"
    description "This is the test course description"
    cost 1300.00
    association :user
  end
end

FactoryGirl.define do
  factory :section do
    title "Test Section"
    association :course
  end
end

FactoryGirl.define do
  factory :lesson do
    title "Test Lesson"
    subtitle "Test Lesson Subtitle"
    association :section
  end
end