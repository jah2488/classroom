FactoryGirl.define do
  factory :campus do
    name { Faker::Name.name }
    time_zone { Faker::Address.time_zone }
  end
end
