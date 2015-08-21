FactoryGirl.define do
  factory :day do
    cohort
    start { Faker::Time.between(cohort.start_time.in_time_zone(cohort.tz), cohort.start_time.in_time_zone(cohort.tz).end_of_day) }
  end
end
