class EventSignupsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "event_signups_channel"
  end
end
