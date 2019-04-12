desc "This task is called by the Heroku scheduler add-on"
task :keep_profiles_updated => :environment do
  puts "Updating profiles..."
  NewsFeed.update
  puts "done."
end
