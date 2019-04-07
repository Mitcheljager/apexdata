class ProfilesController < ApplicationController
  require "httparty"

  before_action do
    unless Flipper.enabled?(:profiles)
      redirect_to root_path
    end
  end

  def index
  end

  def show
    url = "http://api.apexlegendsstatus.com/bridge?platform=#{ params[:platform].upcase }&player=#{ params[:user] }&auth=MqoOOiZTU1H8ADHItbfI"
    response = HTTParty.get(url)
    @response = JSON.parse(response)

    respond_to do |format|
      format.html
      format.json { render json: @response }
    end
  end
end
