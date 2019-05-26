class DistributedBadgesController < ApplicationController
  before_action only: [:index] do
    redirect_to account_path unless current_user && current_user.level == 100
  end

  def index
    @distributed_badges = DistributedBadge.all
  end

  def update
  end
end
