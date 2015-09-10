FactoryGirl.define do
  factory :assignment do
    cohort
    title { Faker::Name.name }
    factory :assignment_w_submissions do
      transient do
        submissions_count 2
      end
      after(:create) do |assignment, evaluator|
        create_list(:submission, evaluator.submissions_count, assignment: assignment)
      end
    end
  end
end
