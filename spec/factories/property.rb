FactoryBot.define do
  factory :property do
    address { Faker::Address.street_address }
    unit_number { Faker::Address.secondary_address }
    price 10_000
    status 'Active'
    description 'Generic Description of property'
    bathroom_count 1
    bedroom_count 3
    property_type 'Condo'
    square_feet 1000
    total_rooms 100
    agents { create_list(:agent, 2) }
  end
end
