module Types
  class QueryType < Types::BaseObject
    field :agents, [Types::AgentType], null: false

    def agents
      Agent.all
    end

    field :agent, Types::AgentType, null: false do
      argument :id, ID, required: true
    end

    def agent(id:)
      Agent.find(id)
    end

    field :properties, [Types::PropertyType], null: false

    def properties
      Property.all
    end

    field :property, Types::PropertyType, null: false do
      argument :id, ID, required: true
    end

    def property(id:)
      Property.find(id)
    end
  end
end
