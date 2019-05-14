class Mutations::CreateAgent < Mutations::BaseMutation
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :phone_number, String, required: true
  argument :email, String, required: true

  field :agent, Types::AgentType, null: false
  field :errors, [String], null: false

  def resolve(first_name:, last_name:, phone_number:, email:)
    agent = Agent.new(first_name: first_name, last_name: last_name, phone_number: phone_number, email: email)
    if agent.save
      {
        agent: agent,
        errors: []
      }
    else
      {
        agent: nil,
        errors: []
      }
    end
  end
end
