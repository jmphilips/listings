class AgentsController < ApplicationController
  before_action :set_agent, only: %i[show update assign]
  before_action :create_agent, only: [:create]
  before_action :update_agent, only: [:update]
  before_action :assign_agent, only: [:assign]

  def index
    render json: Agent.all, status: :ok
  end

  def show
    render json: @agent, status: :ok
  end

  def create
    render json: @agent, status: :created
  end

  def update
    render json: @agent, status: :ok
  end

  def assign
    render json: @agent, status: :ok
  end

  private

  def assign_agent
    @agent.properties << Property.find(assign_params)
  end

  def create_agent
    @agent = Agent.create!(agent_params)
  end

  def set_agent
    @agent = Agent.find(params[:id])
  end

  def update_agent
    @agent.update!(agent_params)
  end

  def agent_params
    params.require(:agent).permit(:first_name, :last_name, :email, :phone_number)
  end

  def assign_params
    params.require(:property_id)
  end
end
