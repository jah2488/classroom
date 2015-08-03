FactoryGirl.define do
  factory :campus do
    name { Faker::Name.name }
    tz { Zonebie.random_timezone }
  end
end
