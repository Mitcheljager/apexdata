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
    if response
      @response = JSON.parse(response)
    end

    if @response["global"]
      @saved_values = ProfileLegendData.where(profile_uid: @response["global"]["uid"]).where.not(data_value: 0)
    else
      @saved_values = nil
    end

    if @response["legends"]["selected"]
      saveNewValues
      keepValuesUpdated
    end

    @claimedProfile = ClaimedProfile.where(profile_uid: @response["global"]["uid"], checks_completed: 1).last


    respond_to do |format|
      format.html
      format.json
    end
  end

  def check_online
    url = "http://api.mozambiquehe.re/bridge?platform=PC&player=mitsiee&auth=iokwcDa2wJKnnfkp193u"
    response = HTTParty.get(url)
    if response
      @response = JSON.parse(response)
    end

    if @response["realtime"]["isOnline"] == 1
      puts "is online"
    else
      puts "is not online"
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

def keepValuesUpdated
  Thread.new do
    duration = 2.minutes
    interval = 10.seconds
    number_of_questions_left = duration.seconds / interval.seconds

    while(number_of_questions_left > 0) do
      puts "Updating"
      number_of_questions_left -= 1
      sleep(interval)
    end
  end
end
