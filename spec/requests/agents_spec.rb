require 'rails_helper'

RSpec.describe 'Agents', type: :request do
  describe 'get /agents' do
    context 'when all agents are requested' do
      it 'returns an http status of 200' do
        create_list(:agent, 3)
        get '/agents'

        expect(response).to have_http_status(:ok)
      end

      it 'returns all of the agents' do
        create_list(:agent, 3)
        get '/agents'

        expect(response).to have_http_status(:ok)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(3)
      end
    end
  end

  describe 'get /agents/:id' do
    context 'when a single agent is requested' do
      it 'returns an http status of 200' do
        agent = create(:agent)
        get "/agents/#{agent.id}"
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct agent' do
        agent = create(:agent)
        create_list(:agent, 3)

        get "/agents/#{agent.id}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['first_name']).to eq(agent.first_name)
        expect(parsed_response['last_name']).to eq(agent.last_name)
        expect(parsed_response['email']).to eq(agent.email)
        expect(parsed_response['phone_number']).to eq(agent.phone_number)
      end
    end
  end

  describe 'post /agents' do
    context 'when an agent is created' do
      it 'returns an http status of 201' do
        agent_params = {
          agent: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            phone_number: Faker::PhoneNumber.phone_number
          }
        }
        post '/agents', params: agent_params
        expect(response).to have_http_status(:created)
      end

      it 'saves a user to the database' do
        agent_params = {
          agent: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            phone_number: Faker::PhoneNumber.phone_number
          }
        }
        post '/agents', params: agent_params
        parsed_response = JSON.parse(response.body)
        agent = Agent.find_by!(email: parsed_response['email'])
        expect(agent).to_not be_nil
      end

      it 'returns the created user' do
        agent_params = {
          agent: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            phone_number: Faker::PhoneNumber.phone_number
          }
        }
        post '/agents', params: agent_params
        parsed_response = JSON.parse(response.body)
        agent = Agent.find_by!(email: parsed_response['email'])

        expect(agent.first_name).to eq(parsed_response['first_name'])
        expect(agent.last_name).to eq(parsed_response['last_name'])
        expect(agent.email).to eq(parsed_response['email'])
        expect(agent.phone_number).to eq(parsed_response['phone_number'])
      end
    end
  end

  describe 'put /agents/:id' do
    context 'when an agent is updated' do
      it 'returns an http status of 200' do
        agent = create(:agent)
        agent_params = {
          agent: {
            first_name: 'Bender'
          }
        }
        put "/agents/#{agent.id}", params: agent_params
        expect(response).to have_http_status(:ok)
      end

      it 'updates the agent in the database' do
        agent = create(:agent)
        agent_params = {
          agent: {
            first_name: 'Bender'
          }
        }
        put "/agents/#{agent.id}", params: agent_params
        agent.reload
        expect(agent.first_name).to eq(agent_params[:agent][:first_name])
      end

      it 'returns the updated user' do
        agent = create(:agent)
        agent_params = {
          agent: {
            first_name: 'Bender'
          }
        }
        put "/agents/#{agent.id}", params: agent_params
        parsed_response = JSON.parse(response.body)
        agent.reload
        expect(agent.first_name).to eq(parsed_response['first_name'])
        expect(agent.last_name).to eq(parsed_response['last_name'])
        expect(agent.email).to eq(parsed_response['email'])
        expect(agent.phone_number).to eq(parsed_response['phone_number'])
      end
    end
  end

  describe 'post /agents/:id' do
    context 'when assigning a property to an agent'
    it 'should return http status ok' do
      agent = create(:agent)
      property = create(:property)
      property_params = {
        property_id: property.id
      }
      post "/agents/#{agent.id}", params: property_params
      expect(response).to have_http_status(:ok)
    end

    # TODO
    # Write the next two tests for testing responses
  end
end
