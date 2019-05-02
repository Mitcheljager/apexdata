class EventSignupsController < ApplicationController
  before_action :set_event_signup, only: [:update, :destroy]
  before_action do
    unless Flipper.enabled?(:events)
      redirect_to root_path
    end
  end

  def create
    claimed_profile = ClaimedProfile.find_by_user_id_and_profile_uid_and_checks_completed(current_user.id, event_signup_params[:profile_uid], 1)

    if claimed_profile.present?
      @event_signup = EventSignup.new(event_signup_params.merge(user_id: current_user.id))
      respond_to do |format|
        if @event_signup.save
          format.js
        else
          format.js { render "error.js.erb" }
        end
      end
    else
      puts "Profile does not match user"
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_event_signup
    @event_signup = EventSignup.find(params[:id])
  end

  def event_signup_params
    params.require(:event_signup).permit(:event_id, :profile_uid)
  end
end
