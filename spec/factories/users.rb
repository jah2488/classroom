FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    after(:create) { |i| i.confirm }
    factory :instructor_user do
      instructor
    end
    factory :student_user do
      student
    end
    factory :full_user do
      name { Faker::Name.name }
      github { Faker::Internet.user_name(name) }
      phone { Faker::PhoneNumber.cell_phone }
    end
  end
end
