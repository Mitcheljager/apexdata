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

    if @response["global"]
      @savedValues = ProfileLegendData.where(user_id: @response["global"]["uid"])
    else
      @savedValues = nil
    end

    if @response["legends"]["selected"]
      saveNewValues
    end

    respond_to do |format|
      format.html
      format.json { render json: @response }
    end
  end

  private

  def saveNewValues
    user_id = @response["global"]["uid"]
    legend = @response["realtime"]["selectedLegend"]

    @response["legends"]["selected"].each do |legend, data|
      data.each do |key, value|
        currentData = ProfileLegendData.find_by_user_id_and_data_name_and_data_value(user_id, key, value)

        if currentData.nil?
          @new_entry = ProfileLegendData.new(user_id: user_id, data_name: key, data_value: value)
          @new_entry.save
        end
      end
    end
  end
end
