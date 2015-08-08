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
    factory :full_user do
      name { Faker::Name.name }
      github { Faker::Internet.user_name(name) }
    end
  end
end
