FactoryGirl.define do
  factory :day do
    cohort
    start { Time.now }
  end
end
