require "httparty"

desc "Keep claimed profiles updated by checking the api periodically."
task :keep_profiles_updated => :environment do
  duration = 10.minutes
  interval = 20.seconds
  number_of_checks_left = duration.seconds / interval.seconds
  infinite_checks = true
  platforms = ["X1", "PS4", "PC"]

  Thread.new do
    while(infinite_checks) do
      platforms.each do |platform|
        profiles = []

        Rails.logger.silence do
          active_memberships = Membership.where("created_at > ?", 1.month.ago).each do |membership|
            user = User.find_by_id(membership.user_id)
            claimed_profiles = ClaimedProfile.where(checks_completed: 1, user_id: user.id, platform: platform).select(:profile_uid).map(&:profile_uid)

            if claimed_profiles.any?
              profiles.push(claimed_profiles)
            end
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

                  profile["legends"]["selected"][legend].each do |key, value|
                    next if key == "ImgAssets"

                    Rails.logger.silence do
                      currentData = ProfileLegendData.find_by_profile_uid_and_legend_and_data_name_and_data_value(profile_uid, legend, key, value.to_i)

                      if currentData.nil?
                        @new_entry = ProfileLegendData.new(profile_uid: profile_uid, legend: legend, data_name: key, data_value: value)
                        @new_entry.save
                      end
                    end
                  end
                end
              end

              Rails.logger.info "Updated #{ profile["global"]["name"] }"
            end
          rescue => error
            Rails.logger.debug "Response faulty: #{ error }"
          end
        end
      end

      Rails.logger.info "Check cycle complete"

      sleep(interval)
    end
  end
end
