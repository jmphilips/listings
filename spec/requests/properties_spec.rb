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
end
