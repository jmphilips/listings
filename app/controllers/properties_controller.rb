class PropertiesController < ApplicationController
  def index
    render json: Property.all, status: :ok
  end

  def show
    property = Property.find(params[:id])
    render json: property, status: :ok
  end
end
