class AgentSerializer < ActiveModel::Serializer
  attributes :email, :phone_number, :first_name, :last_name
end
