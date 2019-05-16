class ServerStatusController < ApplicationController
  before_action do
    unless Flipper.enabled?(:server_status)
      redirect_to root_path
    end
  end

  def index
    @server_status = ServerStatus.all
  end
end
