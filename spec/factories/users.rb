FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { DateTime.now }
    factory :instructor_user do
      instructor
    end
    factory :student_user do
      student
    end
  end
end
