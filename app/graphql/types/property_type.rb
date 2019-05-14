module Types
  class PropertyType < Types::BaseObject
    field :id, ID, null: false
    field :property_type, String, null: true
    field :address, String, null: true
    field :unit_number, String, null: true
    field :price, Integer, null: true
    field :status, String, null: true
    field :description, String, null: true
    field :bathroom_count, Integer, null: true
    field :bedroom_count, Integer, null: true
    field :square_feet, Integer, null: true
    field :total_rooms, Integer, null: true
  end
end
