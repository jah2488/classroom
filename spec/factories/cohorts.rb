FactoryGirl.define do
  factory :cohort do
    name { Faker::App.name }
    campus
    first_day { DateTime.now }
    factory :cohort_w_stuff do
      transient do
        assignments_count 5
      end
      after(:create) do |cohort, evaluator|
        create_list(:assignment_w_submissions, evaluator.assignments_count, cohort: cohort)
      end
    end
  end
end
