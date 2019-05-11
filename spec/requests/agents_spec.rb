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
end
