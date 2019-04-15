require "httparty"

desc "Keep claimed profiles updated by checking the api periodically."
task :keep_profiles_updated => :environment do
  puts "Updating profiles..."

  duration = 10.minutes
  interval = 20.seconds
  number_of_checks_left = duration.seconds / interval.seconds
  infinite_checks = true

  profiles = ClaimedProfile.where(checks_completed: 1).select(:username).map(&:username).join(",")

  Thread.new do
    while(infinite_checks) do
      url = "http://api.mozambiquehe.re/bridge?platform=PC&player=#{ profiles }&auth=iokwcDa2wJKnnfkp193u&version=2"
      response = HTTParty.get(url)

      if response
        @response = JSON.parse(response)
        @response = Array.wrap(@response)

        @response.each do |profile|
          if profile["realtime"]["isOnline"] == 1
            profile_uid = profile["global"]["uid"]
            legend = profile["realtime"]["selectedLegend"]

            profile["legends"]["selected"][legend].each do |key, value|
              next if key == "ImgAssets"

              currentData = ProfileLegendData.find_by_profile_uid_and_legend_and_data_name_and_data_value(profile_uid, legend, key, value)

              if currentData.nil?
                @new_entry = ProfileLegendData.new(profile_uid: profile_uid, legend: legend, data_name: key, data_value: value)
                @new_entry.save
              end
            end
          end

          puts "Updated #{ profile["global"]["name"] }"
        end
      else
        puts "Response faulty"
      end

      puts "Check cycle complete"

      sleep(interval)
    end
  end
end
