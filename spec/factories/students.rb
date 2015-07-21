FactoryGirl.define do
  factory :student do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    cohort
  end

end
