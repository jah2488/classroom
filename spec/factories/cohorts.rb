FactoryGirl.define do
  factory :cohort do
    name { Faker::App.name }
    campus
    start_date { Faker::Time.forward(30).to_datetime }
    transient do
      instructors_count 1
    end
    after(:create) do |cohort, evaluator|
      create_list(:cohort_instructor, evaluator.instructors_count, cohort: cohort)
    end
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
