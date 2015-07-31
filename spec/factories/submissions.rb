FactoryGirl.define do
  factory :submission do
    student
    completed false
    state Submission::PENDING
    link { Faker::Internet.url }
  end
end
