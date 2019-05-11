require 'rails_helper'

RSpec.describe 'Agents', type: :request do
  describe 'get /agents' do
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

  describe 'get /agents/:id' do
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

# require "rails_helper"

# RSpec.describe "Widget management", :type => :request do

#   it "creates a Widget and redirects to the Widget's page" do
#     get "/widgets/new"
#     expect(response).to render_template(:new)

#     post "/widgets", :widget => {:name => "My Widget"}

#     expect(response).to redirect_to(assigns(:widget))
#     follow_redirect!

#     expect(response).to render_template(:show)
#     expect(response.body).to include("Widget was successfully created.")
#   end

#   it "does not render a different template" do
#     get "/widgets/new"
#     expect(response).to_not render_template(:show)
#   end
# end
