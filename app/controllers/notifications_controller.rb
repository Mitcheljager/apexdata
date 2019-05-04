class NotificationsController < ApplicationController
  before_action do
    unless Flipper.enabled?(:notifications)
      redirect_to root_path
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def create
  end

  def update
  end
end
