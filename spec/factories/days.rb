FactoryGirl.define do
  factory :day do
    cohort
    start { Faker::Time.between(cohort.start_time + 1.second, cohort.start_time + 3.months) }
  end
end
