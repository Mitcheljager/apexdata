class ProfilesController < ApplicationController
  before_action do
    unless Flipper.enabled?(:profiles)
      redirect_to root_path
    end
  end

  def index
  end

  def show
  end
end
