require "httparty"

desc "Update leaderboard for several events."
task :update_event_leaderboards => :environment do
  next unless Flipper.enabled?(:keep_events_updated)

  Thread.new do
    loop do
      Rails.logger.silence do
        active_events = Event.where("start_datetime < ?", DateTime.now).where("end_datetime > ?", DateTime.now)
        active_events.each do |event|
          event_data_names = JSON.parse event.data_names

          event.event_signups.each do |event_signup|
            claimed_profile = ClaimedProfile.find_by_checks_completed_and_profile_uid(1, event_signup.profile_uid)

            if claimed_profile.present?
              begin
                get_response(claimed_profile.profile_uid, claimed_profile.platform)

                if @response.present?
                  profile_uid = @response["global"]["uid"]
                  legend = @response["realtime"]["selectedLegend"]

                  event_data_names.each do |data_name|
                    if @response["legends"]["selected"][legend][data_name]
                      save_data(claimed_profile.profile_uid, event, event_signup, legend, data_name)

                    end
                  end

                  puts "Event: #{ event.title } - Updated #{ claimed_profile.username }"
                end
              rescue => error
                puts "Response faulty: #{ error }"
              end
            end
          end

          puts "Event: #{ event.title } - Cycle complete"
        end
      end

      sleep(5)
    end
  end
end

private

def get_response(profile_uid, platform)
  url = "#{ ENV["APEX_API_URL"] }/bridge?platform=#{ platform }&uid=#{ profile_uid }&auth=#{ ENV["APEX_API_KEY"] }&version=2"
  response = HTTParty.get(url, timeout: 5)

  @response = JSON.parse(response)
end

def save_data(profile_uid, event, event_signup, legend, data_name)
  data_value = @response["legends"]["selected"][legend][data_name]
  current_legend_data = EventLegendData.find_by_event_id_and_profile_uid_and_legend(event.id, profile_uid, legend)

  if current_legend_data.nil?
    @new_entry = EventLegendData.new(event_id: event.id, profile_uid: profile_uid, legend: legend, initial_value: data_value, current_value: data_value)
    @new_entry.save
  else
    if current_legend_data.current_value.to_s != data_value.to_s
      total_value = event_signup.total_value.to_f + (data_value - current_legend_data.current_value.to_f)

      current_legend_data.update(current_value: data_value)
      event_signup.update(total_value: total_value.round)

      ActionCable.server.broadcast "events_channel_#{ event.id }", data_value: total_value.round, profile_uid: profile_uid
    end
  end
end
