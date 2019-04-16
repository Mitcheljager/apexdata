class ClaimedProfilesController < ApplicationController
  include ContentHelper
  require "httparty"

  def initiate
    setApiData

    available_legends = ["Bangalore", "Bloodhound", "Gibraltar", "Lifeline", "Pathfinder", "Wraith"]
    step_1_legend = available_legends.sample
    available_legends.delete(step_1_legend)
    step_2_legend = available_legends.sample
    available_legends.delete(step_2_legend)
    step_3_legend = available_legends.sample

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
        @claimed_profile.update(checks_completed: 1, username: @response["realtime"]["name"], platform: @response["realtime"]["platform"])
        format.js
      else
        format.js { render "error.js.erb" }
      end
    end
  end

  def destroy
    @claimed_profile = ClaimedProfile.find(params[:id])
    redirect_to user_path if @claimed_profile.id != current_user.id
    redirect_to claimed_profile
  end

  private

  def getClaimedProfile
    url = "http://api.mozambiquehe.re/bridge?platform=#{ claimed_profile_params[:platform].upcase }&player=#{ claimed_profile_params[:user] }&auth=iokwcDa2wJKnnfkp193u&version=2"
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
