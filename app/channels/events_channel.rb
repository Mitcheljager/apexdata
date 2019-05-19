class EventsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "events_channel_#{ params[:event_id] }"
  end
end
