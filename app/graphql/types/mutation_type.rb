module Types
  class MutationType < Types::BaseObject
    field :create_agent, mutation: Mutations::CreateAgent
    field :assign_agent, mutation: Mutations::AssignAgent
  end
end
