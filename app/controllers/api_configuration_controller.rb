class ApiConfigurationController < ApplicationController
  before_filter :new_api

  def index
  end

  def create
    @api.assign_attributes(
        url: param[:url], key: param[:key]
    )

    if @api.save
      flash[:success] = 'API saved!'
      redirect_to api_configuration_index_path
    else
      render 'index'
    end
  end

  def update
    api = Config::RaceApi.find(params[:id])
    api.live_update = params[:active]
    api.save
    redirect_to api_configuration_index_path
  end

  def destroy
    api = Config::RaceApi.find(params[:id])
    api.destroy
    redirect_to api_configuration_index_path
  end

  private

  def param
    params[:api]
  end

  def new_api
    @api = Config::RaceApi.new
    @apis = Config::RaceApi.all
  end
end