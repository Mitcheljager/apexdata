class MembershipsController < ApplicationController
  before_action do
    unless Flipper.enabled?(:memberships)
      redirect_to root_path
    end
  end

  def new
  end

  def create
    @membership = Membership.new(user_id: current_user.id, payment_complete: 1, order_id: params[:order_id])
    @membership.save
  end

  def update
  end
end
