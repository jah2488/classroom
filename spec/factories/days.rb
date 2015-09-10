FactoryGirl.define do
  factory :day do
    cohort
    start { Faker::Time.between(cohort.start_time + 5.seconds, cohort.start_time + 3.months) }
  end
end
