class ClaimedProfilesController < ApplicationController
  include ContentHelper
  require "httparty"

  before_action only: [:index] do
    redirect_to account_path unless current_user && current_user.level == 100
  end

  def index
    @successful_claimed_profiles = ClaimedProfile.where(checks_completed: 1).order(created_at: :asc)
    @failed_claimed_profiles = ClaimedProfile.where(checks_completed: 0).order(created_at: :asc)
  end

  def initiate
    set_api_data

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
    set_api_data
    get_claimed_profile

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
    set_api_data
    get_claimed_profile

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
    get_claimed_profile

    respond_to do |format|
      if @response["realtime"]["selectedLegend"] == @claimed_profile[:check_3]
        @claimed_profile.update(checks_completed: 1, username: @response["global"]["name"], platform: @response["global"]["platform"])
        format.js
      else
        format.js { render "error.js.erb" }
      end
    end
  end

  def destroy
    @claimed_profile = ClaimedProfile.find(params[:id])
    return if @claimed_profile.user_id != current_user.id

    if @claimed_profile.delete
      redirect_to account_path
    end
  end

  private

  def get_claimed_profile
    url = "http://premium-api.mozambiquehe.re/bridge?platform=#{ claimed_profile_params[:platform].upcase }&player=#{ claimed_profile_params[:user] }&auth=iokwcDa2wJKnnfkp193u&version=2"
    response = HTTParty.get(url)
    if response
      @response = JSON.parse(response)
      @claimed_profile = ClaimedProfile.where(user_id: current_user.id, profile_uid: @response["global"]["uid"], created_at: 30.minutes.ago..DateTime.now).last
    end
  end

  def set_api_data
    @user = claimed_profile_params[:user]
    @platform = claimed_profile_params[:platform]
  end

  def claimed_profile_params
    params.require(:claimed_profile).permit(:profile_uid, :platform, :user)
  end
end
