class LegendsController < ApplicationController
  include ContentHelper

  def index
    Discord::Notifier.message("Discord Notifier Webhook Notification") if Rails.env.production?
  end

  def show
    @item = legend(params[:name])
  end
end
