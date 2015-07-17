FactoryGirl.define do
  factory :instructor do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

end
