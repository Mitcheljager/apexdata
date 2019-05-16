class ServerStatusController < ApplicationController
  def index
    @server_status = ServerStatus.all
  end
end
