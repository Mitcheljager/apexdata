require "httparty"

desc "This task is called by the Heroku scheduler add-on"
task :keep_profiles_updated => :environment do
  puts "Updating profiles..."

  duration = 10.minutes
  interval = 10.seconds
  number_of_checks_left = duration.seconds / interval.seconds

  Thread.new do
    while(number_of_checks_left > 0) do
      ClaimedProfile.where(checks_completed: 1).each do |profile|
        url = "http://api.mozambiquehe.re/bridge?platform=#{ profile.platform }&player=#{ profile.username }&auth=iokwcDa2wJKnnfkp193u"
        response = HTTParty.get(url)
        if response
          @response = JSON.parse(response)
        end

        if @response["realtime"]["isOnline"] == 1
          profile_uid = @response["global"]["uid"]
          legend = @response["realtime"]["selectedLegend"]

          @response["legends"]["selected"].each do |legend, data|
            data.each do |key, value|
              currentData = ProfileLegendData.find_by_profile_uid_and_legend_and_data_name_and_data_value(profile_uid, legend, key, value)

              if currentData.nil?
                @new_entry = ProfileLegendData.new(profile_uid: profile_uid, legend: legend, data_name: key, data_value: value)
                @new_entry.save
              end
            end
          end
        end

        puts "Updating #{ @response["global"]["name"] }"
      end

      number_of_checks_left -= 1
      sleep(interval)
    end
  end

  sleep(duration)

  puts "Done updating profiles"
end
