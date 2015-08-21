FactoryGirl.define do
  factory :day do
    cohort
    start { Faker::Time.between(cohort.start_time, cohort.start_time + 3.months) }
  end
end
