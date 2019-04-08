class ClaimedProfilesController < ApplicationController
  include ContentHelper
  require "httparty"

  def initiate
    setApiData
    step_1_legend = legends_list.sample
    step_2_legend = legends_list.sample
    step_3_legend = legends_list.sample

    @claimed_profile = ClaimedProfile.new(user_id: current_user.id, profile_uid: claimed_profile_params[:profile_uid], check_1: step_1_legend, check_2: step_2_legend, check_3: step_3_legend)
    @current_legend = @claimed_profile.check_1

    if @claimed_profile.save
      respond_to  do |format|
        format.js
      end
    end
  end

  def step_1
    setApiData
    getClaimedProfile

    @current_legend = @claimed_profile.check_2

    respond_to do |format|
      if @response["realtime"]["selectedLegend"] == @claimed_profile[:check_1]
        format.js
      else
        format.js { render "error.js.erb" }
      end
    end
  end

  def step_2
    setApiData
    getClaimedProfile

    @current_legend = @claimed_profile.check_3

    respond_to do |format|
      if @response["realtime"]["selectedLegend"] == @claimed_profile[:check_2]
        format.js
      else
        format.js { render "error.js.erb" }
      end
    end
  end

  def step_3
    getClaimedProfile

    respond_to do |format|
      if @response["realtime"]["selectedLegend"] == @claimed_profile[:check_3]
        @claimed_profile.update(checks_completed: 1)
        format.js
      else
        format.js { render "error.js.erb" }
      end
    end
  end

  private

  def getClaimedProfile
    url = "http://api.apexlegendsstatus.com/bridge?platform=#{ claimed_profile_params[:platform].upcase }&player=#{ claimed_profile_params[:user] }&auth=MqoOOiZTU1H8ADHItbfI"
    response = HTTParty.get(url)
    if response
      @response = JSON.parse(response)
      @claimed_profile = ClaimedProfile.where(user_id: current_user.id, profile_uid: @response["global"]["uid"]).last
    end
  end

  def setApiData
    @user = claimed_profile_params[:user]
    @platform = claimed_profile_params[:platform]
  end

  def claimed_profile_params
    params.require(:claimed_profile).permit(:profile_uid, :platform, :user)
  end
end
