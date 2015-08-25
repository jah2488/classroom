FactoryGirl.define do
  factory :campus do
    name { Faker::Name.name }
    time_zone { Zonebie.random_timezone }
  end
end
