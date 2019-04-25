class MembershipsController < ApplicationController
  before_action do
    unless Flipper.enabled?(:memberships)
      redirect_to root_path
    end
  end

  before_action only: [:index] do
    redirect_to account_path unless current_user && current_user.level == 100
  end

  def index
    @memberships = Membership.all.order(created_at: :asc)
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
