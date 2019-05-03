require "httparty"

desc "Update leaderboard for several events."
task :update_event_leaderboards => :environment do
  interval = 30.seconds
  platforms = ["X1", "PS4", "PC"]

  Thread.new do
    loop do
      Rails.logger.silence do
        active_events = Event.where("start_datetime < ?", DateTime.now).where("end_datetime > ?", DateTime.now)
        active_events.each do |event|
          event_data_names = JSON.parse event.data_names

          platforms.each do |platform|
            profiles = []

            event.event_signups.each do |event_signup|
              claimed_profiles = ClaimedProfile.where(checks_completed: 1, profile_uid: event_signup.profile_uid, platform: platform).select(:profile_uid).map(&:profile_uid)

              if claimed_profiles.any?
                profiles.push(claimed_profiles)
              end
            end

            if profiles.any?
              begin
                profiles = profiles.join(",")
                url = "http://premium-api.mozambiquehe.re/bridge?platform=#{ platform }&uid=#{ profiles }&auth=iokwcDa2wJKnnfkp193u&version=2"
                response = HTTParty.get(url, timeout: 10)

                @response = JSON.parse(response)
                @response = Array.wrap(@response)

                @response.each do |profile|
                  if profile["realtime"]
                    if profile["realtime"]["isOnline"] == 1
                      profile_uid = profile["global"]["uid"]
                      legend = profile["realtime"]["selectedLegend"]

                      event_data_names.each do |data_name|
                        if profile["legends"]["selected"][legend][data_name]
                          data_value = profile["legends"]["selected"][legend][data_name]
                          currentLegendData = EventLegendData.find_by_event_id_and_profile_uid_and_legend(event.id, profile_uid, legend)

                          if currentLegendData.nil?
                            @new_entry = EventLegendData.new(event_id: event.id, profile_uid: profile_uid, legend: legend, initial_value: data_value, current_value: data_value)
                            @new_entry.save
                          else
                            if currentLegendData.current_value != data_value.to_s
                              currentLegendData.update(current_value: data_value)

                              @signup = EventSignup.find_by_event_id_and_profile_uid(event.id, profile_uid)
                              total_value = @signup.total_value.to_f + data_value.to_f
                              @signup.update(total_value: total_value)
                            end
                          end
                        end
                      end
                    end
                  end
                end
              rescue => error
                puts "Response faulty: #{ error }"
              end
            end
          end
        end
      end

      puts "Event cycle complete"

      sleep(interval)
    end
  end
end
