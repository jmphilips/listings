class PropertiesController < ApplicationController
  def index
    render json: Property.all, status: :ok
  end

  def show
    property = Property.find(params[:id])
    render json: property, status: :ok
  end

  def create
    property = Property.create(property_params)
    render json: property, status: :created
  end

  def assign
    property = Property.find(params[:id])
    agent = Agent.find(assign_params)
    property.agents << agent
    render json: property, status: :ok
  end

  private

  def property_params
    params.require(:property).permit(:address, :unit_number, :price, :status, :description, :bathroom_count, :bedroom_count, :property_type, :square_feet, :total_rooms)
  end

  def assign_params
    params.require(:agent_id)
  end
end
