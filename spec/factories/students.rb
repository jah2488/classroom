FactoryGirl.define do
  factory :student do
    cohort
    factory :full_student do
      phone { Faker::PhoneNumber.cell_phone }
      blog { Faker::Internet.url('blogger.com') }
      bio { Faker::Lorem.sentence }
      user
      twitter { Faker::Internet.user_name(user.name) }
    end
  end
end
