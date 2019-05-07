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

      if claimed_profile.present?
        @event_signup = EventSignup.new(event_signup_params.merge(user_id: current_user.id))
        respond_to do |format|
          if @event_signup.save
            format.js
          else
            puts @event_signup.errors.full_messages
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

  private

  def set_event_signup
    @event_signup = EventSignup.find(params[:id])
  end

  def event_signup_params
    params.require(:event_signup).permit(:event_id, :profile_uid)
  end
end
