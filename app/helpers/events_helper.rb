module EventsHelper
  def get_last_played_event_legend(uid)
    event_legend_data = EventLegendData.where(profile_uid: uid).order(updated_at: :desc).first

    return event_legend_data.legend
  end
end
