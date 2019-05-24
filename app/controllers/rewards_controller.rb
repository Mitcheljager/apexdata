class RewardsController < ApplicationController
  include NotificationsHelper

  before_action do
    redirect_to account_path unless current_user && current_user.level == 100
  end

  def index
    @rewards = Reward.all
  end

  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)

    if @reward.save
      create_notification("You've received a reward for participating in an Event.", account_path, reward_params[:user_id])
      redirect_to rewards_path, notice: "Reward was successfully created."
    else
      render :new
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:user_id, :title, :description, :content)
  end
end
