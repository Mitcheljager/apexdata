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
    url = "http://api.mozambiquehe.re/bridge?platform=#{ params[:platform].upcase }&player=#{ params[:user] }&auth=iokwcDa2wJKnnfkp193u&version=2"
    begin
      response = HTTParty.get(url)
    rescue HTTParty::Error
      render "not_found"
      return
    rescue StandardError
      render "not_found"
      return
    end

    if response
      @response = JSON.parse(response)
    end

    if @response["global"]
      @saved_values = ProfileLegendData.where(profile_uid: @response["global"]["uid"]).where.not(data_value: 0)
    else
      render "not_found"
      return
    end

    if @response["legends"]["all"]
      save_new_values
    end

    @claimed_profile = ClaimedProfile.where(profile_uid: @response["global"]["uid"], checks_completed: 1).last

    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def save_new_values
    profile_uid = @response["global"]["uid"]

    @response["legends"]["all"].each do |legend, data_values|
      next unless data_values["data"]

      data_values["data"].each do |key, data|
        currentData = ProfileLegendData.find_by_profile_uid_and_legend_and_data_name_and_data_value(profile_uid, legend, data["key"], data["value"])


        if currentData.nil?
          @new_entry = ProfileLegendData.new(profile_uid: profile_uid, legend: legend, data_name: data["key"], data_value: data["value"])
          @new_entry.save
        end
      end
    end
  end
end
