require 'csv'

CSV.foreach(Rails.root.join('sample_agents.csv'), headers: true) do |row|
  Agent.create! do |agent|
    agent.first_name = row[0]
    agent.last_name = row[1]
    agent.email = row[2]
    agent.phone_number = row[3]
  end
end

CSV.foreach(Rails.root.join('sample_properties.csv'), headers: true) do |row|
  Property.create! do |property|
    property.address = row[0]
    property.unit_number = row[1]
    property.price = row[2]
    property.status = row[3]
    property.description = row[4]
    property.bathroom_count = row[5]
    property.bedroom_count = row[6]
    property.property_type = row[7]
    property.square_feet = row[8]
    property.total_rooms = row[9]
    agent1 = Agent.find_by(email: row[10])
    agent2 = Agent.find_by(email: row[11])
    property.agents << agent1 if agent1
    property.agents << agent2 if agent2
  end
end
