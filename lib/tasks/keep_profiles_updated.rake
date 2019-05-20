require "httparty"

desc "Keep claimed profiles updated by checking the api periodically."
task :keep_profiles_updated => :environment do
  next unless Flipper.enabled?(:keep_profiles_updated)

  duration = 10.minutes
  interval = 20.seconds

  Thread.new do
    Rails.logger.silence do
      loop do
        profiles_get_active_memberships

        @active_memberships.each do |membership|
          profiles_get_profiles(membership)

          if @claimed_profiles.any?
            @claimed_profiles.each do |claimed_profile|
              begin
                profiles_get_response(claimed_profile)

                if @response
                  @response = JSON.parse(@response)

                  if profiles_is_online?(@response)
                    profiles_save_data(@response)
                  end

                  puts "Updated #{ @response["global"]["name"] }"
                end
              rescue => error
                puts "Response faulty: #{ error }"
              end
            end
          end
        end

        puts "Check cycle complete"

        sleep(interval)
      end
    end
  end
end

private

def profiles_get_active_memberships
  @active_memberships = Membership.where("created_at > ?", 1.month.ago)
end

def profiles_get_profiles(membership)
  user = User.find_by_id(membership.user_id)
  @claimed_profiles = ClaimedProfile.where(user_id: user.id, checks_completed: 1)
end

def profiles_get_response(claimed_profile)
  url = "#{ ENV["APEX_API_URL"] }/bridge?platform=#{ claimed_profile.platform }&uid=#{ claimed_profile.profile_uid }&auth=#{ ENV["APEX_API_KEY"] }&version=2"
  @response = HTTParty.get(url, timeout: 15)
end

def profiles_is_online?(profile)
  if profile["realtime"]
    if profile["realtime"]["isOnline"] == 1
      return true
    else
      return false
    end
  else
    return false
  end
end

def profiles_save_data(profile)
  profile_uid = profile["global"]["uid"]
  legend = profile["realtime"]["selectedLegend"]

  profile["legends"]["selected"][legend].each do |key, value|
    next if key == "ImgAssets"

    currentData = ProfileLegendData.find_by_profile_uid_and_legend_and_data_name_and_data_value(profile_uid, legend, key, value.to_i)

    if currentData.nil?
      @new_entry = ProfileLegendData.new(profile_uid: profile_uid, legend: legend, data_name: key, data_value: value)
      @new_entry.save
    end
  end
end
