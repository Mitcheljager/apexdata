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
    get_response

    if @response["global"]
      @saved_values = ProfileLegendData.where(profile_uid: @response["global"]["uid"]).where.not(data_value: 0)
    else
      render "not_found"
      return
    end

    if @response["legends"]["all"]
      check_latest_update
      if @latest_record
        if @latest_record.created_at > 20.seconds.ago
          save_new_values
        end
      else
        save_new_values
      end
    end

    @claimed_profile = ClaimedProfile.where(profile_uid: @response["global"]["uid"], checks_completed: 1).last

    respond_to do |format|
      format.html
      format.json
    end
  end

  def charts
    get_response

    if @response["global"]
      @saved_values = ProfileLegendData.where(profile_uid: @response["global"]["uid"]).where.not(data_value: 0)
    else
      render "not_found"
      return
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

  def check_latest_update
    @latest_record = ProfileLegendData.find_by_profile_uid(@response["global"]["uid"])
  end

  def get_response
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
  end
end
