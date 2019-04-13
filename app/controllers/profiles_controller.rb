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
    url = "http://api.mozambiquehe.re/bridge?platform=#{ params[:platform].upcase }&player=#{ params[:user] }&auth=iokwcDa2wJKnnfkp193u"
    response = HTTParty.get(url)
    @response = JSON.parse(response)

    if @response["global"]
      @savedValues = ProfileLegendData.where(profile_uid: @response["global"]["uid"])
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
    profile_uid = @response["global"]["uid"]
    legend = @response["realtime"]["selectedLegend"]

    @response["legends"]["selected"].each do |legend, data|
      data.each do |key, value|
        currentData = ProfileLegendData.find_by_profile_uid_and_legend_and_data_name_and_data_value(profile_uid, legend, key, value)

        if currentData.nil?
          @new_entry = ProfileLegendData.new(profile_uid: profile_uid, legend: legend, data_name: key, data_value: value)
          @new_entry.save
        end
      end
    end
  end
end
