class ServerStatusController < ApplicationController
  before_action do
    unless Flipper.enabled?(:server_status)
      redirect_to root_path
    end
  end

  def index
    start_time = Time.now
    check = Net::Ping::External.new("8.8.8.8")

    puts check.ping?
    puts Time.now - start_time

    @server_status = ServerStatus.all
  end
end
