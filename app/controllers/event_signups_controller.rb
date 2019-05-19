class EventSignupsController < ApplicationController
  before_action :set_event_signup, only: [:update, :destroy]
  before_action do
    unless Flipper.enabled?(:events)
      redirect_to root_path
    end
  end

  before_action only: [:index] do
    redirect_to account_path unless current_user && current_user.level == 100
  end

  def index
    @event_signups = EventSignup.all
  end

  def create
    claimed_profile = current_user.claimed_profiles.where(profile_uid: event_signup_params[:profile_uid], checks_completed: 1).last
    signup = EventSignup.find_by_user_id_and_event_id_and_profile_uid(current_user.id, event_signup_params[:event_id], event_signup_params[:profile_uid])

    unless signup.present?
      @event = Event.find(event_signup_params[:event_id])

      return if DateTime.now.localtime > @event.end_datetime.localtime

      if claimed_profile.present?
        @event_signup = EventSignup.new(event_signup_params.merge(user_id: current_user.id))
        respond_to do |format|
          if @event_signup.save
            format.js
          else
            @error_message = "Error signing up. Please try again."
            format.js { render "error.js.erb" }
          end
        end
      end
    end
  end

  def update
  end

  def destroy
  end

  def update_leaderboard_item
    @event = Event.find(event_signup_params[:event_id])
    event_data_names = JSON.parse @event.data_names
    return if DateTime.now.localtime > @event.end_datetime.localtime

    signups = current_user.event_signups.where(event_id: @event.id)

    signups.each do |signup|
      begin
        claimed_profile = ClaimedProfile.find_by_profile_uid_and_checks_completed(signup.profile_uid, 1)
        url = "http://premium-api.mozambiquehe.re/bridge?platform=#{ claimed_profile.platform }&uid=#{ claimed_profile.profile_uid }&auth=iokwcDa2wJKnnfkp193u&version=2"
        response = HTTParty.get(url, timeout: 10)

        @response = JSON.parse(response)

        if @response["realtime"]
          profile_uid = @response["global"]["uid"]
          legend = @response["realtime"]["selectedLegend"]

          event_data_names.each do |data_name|
            if @response["legends"]["selected"][legend][data_name]
              data_value = @response["legends"]["selected"][legend][data_name]
              current_legend_data = EventLegendData.find_by_event_id_and_profile_uid_and_legend(@event.id, profile_uid, legend)

              if current_legend_data.nil?
                @new_entry = EventLegendData.new(event_id: @event.id, profile_uid: profile_uid, legend: legend, initial_value: data_value, current_value: data_value)
                @new_entry.save
              else
                if current_legend_data.current_value != data_value.to_s
                  event_signup = EventSignup.find_by_event_id_and_profile_uid(@event.id, profile_uid)
                  total_value = event_signup.total_value.to_f + (data_value - current_legend_data.current_value.to_f)

                  current_legend_data.update(current_value: data_value)
                  event_signup.update(total_value: total_value.round)
                end
              end
            else
              @error_message = "You do not have the correct Tracker active. Make sure to use '#{ JSON.parse(@event.data_names).first.humanize }' as one of your Trackers."
              respond_to do |format|
                format.js { render "error.js.erb" }
              end

              return
            end
          end
        end
      rescue => error
        Raygun.track_exception(error)

        @error_message = "There was an error retrieving your data. Please try again later. Your score is not lost."
        respond_to do |format|
          format.js { render "error.js.erb" }
        end

        return
      end
    end
  end

  private

  def set_event_signup
    @event_signup = EventSignup.find(params[:id])
  end

  def event_signup_params
    params.require(:event_signup).permit(:event_id, :profile_uid)
  end
end
