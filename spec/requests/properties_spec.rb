require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  describe 'get /properties' do
    context 'when all properties are requested' do
      it 'returns an http status of 200' do
        create_list(:property, 3)
        get '/properties'

        expect(response).to have_http_status(:ok)
      end

      it 'returns all of the properties' do
        create_list(:property, 3)
        get '/properties'

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(3)
      end

      it 'returns the associated agents with properties' do
        create_list(:property, 3)
        get '/properties'

        parsed_response = JSON.parse(response.body)
        first_listing = parsed_response[0]
        expect(first_listing['agents']).not_to be_empty
      end
    end
  end

  describe 'get properties/:id' do
    context 'when a single property is reqeusted' do
      it 'returns an http status of 200' do
        create_list(:property, 2)
        property = create(:property)
        get "/properties/#{property.id}"

        expect(response).to have_http_status(:ok)
      end

      it 'returns the requested property' do
        create_list(:property, 2)
        property = create(:property)
        get "/properties/#{property.id}"

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['address']).to eq(property.address)
        expect(parsed_response['unit_number']).to eq(property.unit_number)
        expect(parsed_response['price']).to eq(property.price)
        expect(parsed_response['status']).to eq(property.status)
        expect(parsed_response['description']).to eq(property.description)
        expect(parsed_response['bathroom_count']).to eq(property.bathroom_count)
        expect(parsed_response['bedroom_count']).to eq(property.bedroom_count)
        expect(parsed_response['property_type']).to eq(property.property_type)
        expect(parsed_response['square_feet']).to eq(property.square_feet)
        expect(parsed_response['total_rooms']).to eq(property.total_rooms)
      end

      it 'returns the requested property associated agents' do
        property = create(:property)
        get "/properties/#{property.id}"

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['agents']).not_to be_empty
        expect(parsed_response['agents'].count).to eq(property.agents.count)
      end
    end
  end

  describe 'post /properties' do
    context 'when a property is created' do
      it 'responds with an http status of 201' do
        property_params = {
          property: {
            address: Faker::Address.street_address,
            unit_number: Faker::Address.secondary_address,
            price: 10_000,
            status: 'Active',
            description: 'Generic Description of property',
            bathroom_count: 1,
            bedroom_count: 3,
            property_type: 'Condo',
            square_feet: 1000,
            total_rooms: 100
          }
        }
        post '/properties', params: property_params

        expect(response).to have_http_status(:created)
      end

      it 'saves a property to the database' do
        property_params = {
          property: {
            address: Faker::Address.street_address,
            unit_number: Faker::Address.secondary_address,
            price: 10_000,
            status: 'Active',
            description: 'Generic Description of property',
            bathroom_count: 1,
            bedroom_count: 3,
            property_type: 'Condo',
            square_feet: 1000,
            total_rooms: 100
          }
        }
        post '/properties', params: property_params

        property = Property.find_by!(address: property_params[:property][:address])
        expect(property).to_not be_nil
      end

      it 'returns the created property' do
        property_params = {
          property: {
            address: Faker::Address.street_address,
            unit_number: Faker::Address.secondary_address,
            price: 10_000,
            status: 'Active',
            description: 'Generic Description of property',
            bathroom_count: 1,
            bedroom_count: 3,
            property_type: 'Condo',
            square_feet: 1000,
            total_rooms: 100
          }
        }
        post '/properties', params: property_params

        property = Property.find_by!(address: property_params[:property][:address])
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['address']).to eq(property.address)
        expect(parsed_response['unit_number']).to eq(property.unit_number)
        expect(parsed_response['price']).to eq(property.price)
        expect(parsed_response['status']).to eq(property.status)
        expect(parsed_response['description']).to eq(property.description)
        expect(parsed_response['bathroom_count']).to eq(property.bathroom_count)
        expect(parsed_response['bedroom_count']).to eq(property.bedroom_count)
        expect(parsed_response['property_type']).to eq(property.property_type)
        expect(parsed_response['square_feet']).to eq(property.square_feet)
        expect(parsed_response['total_rooms']).to eq(property.total_rooms)
      end
    end
  end

  describe 'post properties/id' do
    context 'when assigning an agent to a property' do
      it 'responds with http status 200' do
        property = create(:property)
        agent = create(:agent)
        assign_params = {
          agent_id: agent.id
        }
        post "/properties/#{property.id}", params: assign_params
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the agent to the property' do
        property = create(:property)
        initial_agent_count = property.agents.count
        agent = create(:agent)
        assign_params = {
          agent_id: agent.id
        }
        post "/properties/#{property.id}", params: assign_params
        property.reload
        expect(property.agents.count - initial_agent_count).to eq(1)
        expect(property.agents.pluck(:email)).to include(agent.email)
        expect(property.agents.pluck(:first_name)).to include(agent.first_name)
        expect(property.agents.pluck(:last_name)).to include(agent.last_name)
        expect(property.agents.pluck(:phone_number)).to include(agent.phone_number)
      end
    end
  end
end
