FactoryGirl.define do
  factory :cohort do
    campus
    first_day { DateTime.now }
  end

end
