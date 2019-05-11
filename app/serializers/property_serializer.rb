class PropertySerializer < ActiveModel::Serializer
  attributes :address, :unit_number, :price, :status, :description,
             :bathroom_count, :bedroom_count, :property_type, :square_feet, :total_rooms
  has_many :agents
end
