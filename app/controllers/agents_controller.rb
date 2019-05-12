class AgentsController < ApplicationController
  def index
    render json: Agent.all, status: :ok
  end

  def show
    agent = Agent.find(params[:id])
    render json: agent, status: :ok
  end

  def create
    agent = Agent.create!(agent_params)
    render json: agent, status: :created
  end

  def update
    agent = Agent.find(params[:id])
    agent.update!(agent_params)
    render json: agent, status: :ok
  end

  private

  def agent_params
    params.require(:agent).permit(:first_name, :last_name, :email, :phone_number)
  end
end
