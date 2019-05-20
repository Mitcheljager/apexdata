require "httparty"

desc "Keep claimed profiles updated by checking the api periodically."
task :keep_profiles_updated => :environment do
  next unless Flipper.enabled?(:keep_profiles_updated)

  duration = 10.minutes
  interval = 20.seconds
  number_of_checks_left = duration.seconds / interval.seconds
  infinite_checks = true
  platforms = ["X1", "PS4", "PC"]

  Thread.new do
    Rails.logger.silence do
      while(infinite_checks) do
        platforms.each do |platform|
          get_active_memberships

          @active_memberships.each do |membership|
            get_profiles(membership, platform)

            if @profiles.any?
              begin
                @profiles = @profiles.join(",")
                get_response(platform)

                @response.each do |profile|
                  if is_online?(profile)
                    save_data(profile)
                  end

                  puts "Updated #{ profile["global"]["name"] }"
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

def get_active_memberships
  @active_memberships = Membership.where("created_at > ?", 1.month.ago)
end

def get_profiles(membership, platform)
  @profiles = []

  user = User.find_by_id(membership.user_id)
  claimed_profiles = ClaimedProfile.where(user_id: user.id, checks_completed: 1, platform: platform).select(:profile_uid).map(&:profile_uid)

  if claimed_profiles.any?
    @profiles.push(claimed_profiles)
  end
end

def get_response(platform)
  url = "#{ ENV["APEX_API_URL"] }/bridge?platform=#{ platform }&uid=#{ @profiles }&auth=#{ ENV["APEX_API_KEY"] }&version=2"
  response = HTTParty.get(url, timeout: 15)

  @response = JSON.parse(response)
  @response = Array.wrap(@response)
end

def is_online?(profile)
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

def save_data(profile)
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
