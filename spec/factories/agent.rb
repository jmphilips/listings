FactoryBot.define do
  factory :agent do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
  end
end
