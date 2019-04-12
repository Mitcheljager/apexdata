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
          puts "Updating #{ @response["global"]["name"] }"
        end
      end

      number_of_checks_left -= 1
      sleep(interval)
    end
  end

  sleep(duration)
end
