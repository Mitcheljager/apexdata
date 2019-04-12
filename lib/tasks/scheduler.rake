require "httparty"

desc "This task is called by the Heroku scheduler add-on"
task :keep_profiles_updated => :environment do
  puts "Updating profiles..."

  duration = 2.minutes

  Thread.new do
    ClaimedProfile.where(checks_completed: 1).each do |profile|
      url = "http://api.mozambiquehe.re/bridge?platform=#{ profile.platform }&player=#{ profile.username }&auth=iokwcDa2wJKnnfkp193u"
      response = HTTParty.get(url)
      if response
        @response = JSON.parse(response)
      end

      interval = 10.seconds
      number_of_checks_left = duration.seconds / interval.seconds

      while(number_of_checks_left > 0) do
        puts "Updating #{ @response["global"]["name"] }"
        number_of_checks_left -= 1
        sleep(interval)
      end
    end
  end

  sleep(duration)
end
