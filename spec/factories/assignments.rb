FactoryGirl.define do
  factory :assignment do
    title { Faker::Name.name }
  end
end
