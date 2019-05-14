class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show assign]
  before_action :create_property, only: [:create]

  def index
    render json: Property.all, status: :ok
  end

  def show
    render json: @property, status: :ok
  end

  def create
    render json: @property, status: :created
  end

  def assign
    agent = Agent.find(assign_params)
    @property.agents << agent
    render json: @property, status: :ok
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def create_property
    @property = Property.create(property_params)
  end

  def property_params
    params.require(:property).permit(:address, :unit_number, :price, :status, :description, :bathroom_count, :bedroom_count, :property_type, :square_feet, :total_rooms)
  end

  def assign_params
    params.require(:agent_id)
  end
end
