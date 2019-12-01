class MembershipsController < ApplicationController
  include NotificationsHelper

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

    create_notification("Thank you for purchasing a Membership. Your support is very much appreciated!")
    if Rails.env.production?
      membership = @membership

      embed = Discord::Embed.new do
        title ":moneybag: A user has signed up for a Membership!"
        description "**User ID:** #{ membership.user_id }"
        color "#ffc000"
      end

      Discord::Notifier.message(embed)
    end
  end

  def update
  end
end
