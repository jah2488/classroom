FactoryGirl.define do
  factory :submission do
    student
    link { Faker::Internet.url }
  end
end
