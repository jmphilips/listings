class Mutations::AssignAgent < Mutations::BaseMutation
  argument :agent_id, ID, required: true
  argument :property_id, ID, required: true

  field :agent, Types::AgentType, null: false
  field :property, Types::PropertyType, null: false
  field :errors, [String], null: false

  def resolve(agent_id:, property_id:)
    property = Property.find(property_id)
    agent = Agent.find(agent_id)
    property.agents << agent
    if property.save
      {
        agent: agent,
        property: property,
        errors: []
      }
     else
      {
        agent: nil,
        property: nil,
        errors: []
      }
    end
  end
end