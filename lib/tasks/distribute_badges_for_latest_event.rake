namespace :distribute_badges do
  desc "Distribute Badges for event"
  task :participation, [:event_id, :badge_id] => :environment do |task, args|
    @event = Event.find(args.event_id)

    @event.event_signups.each do |event_signup|
      puts "Gave badge to: #{ event_signup.profile_uid }"

      @badge = DistributedBadge.new(profile_uid: event_signup.profile_uid, badge_id: args.badge_id)
      if @badge.save
        Notification.create(content: "You have earned a badge for participating in '#{ @event.title }'!", user_id: event_signup.user_id)
      end
    end
  end

  task :first_place, [:event_id, :badge_id] => :environment do |task, args|
    @event = Event.find(args.event_id)
    event_signup = @event.event_signups.order(total_value: :desc).first

    puts "Gave badge to: #{ event_signup.profile_uid }"

    @badge = DistributedBadge.new(profile_uid: event_signup.profile_uid, badge_id: args.badge_id)
    if @badge.save
      Notification.create(content: "You have earned a badge for finishing First Place in '#{ @event.title }'!", user_id: event_signup.user_id)
    end
  end

  task :second_place, [:event_id, :badge_id] => :environment do |task, args|
    @event = Event.find(args.event_id)
    event_signup = @event.event_signups.order(total_value: :desc).second

    puts "Gave badge to: #{ event_signup.profile_uid }"

    @badge = DistributedBadge.new(profile_uid: event_signup.profile_uid, badge_id: args.badge_id)
    if @badge.save
      Notification.create(content: "You have earned a badge for finishing Second Place in '#{ @event.title }'!", user_id: event_signup.user_id)
    end
  end

  task :third_place, [:event_id, :badge_id] => :environment do |task, args|
    @event = Event.find(args.event_id)
    event_signup = @event.event_signups.order(total_value: :desc).third

    puts "Gave badge to: #{ event_signup.profile_uid }"

    @badge = DistributedBadge.new(profile_uid: event_signup.profile_uid, badge_id: args.badge_id)
    if @badge.save
      Notification.create(content: "You have earned a badge for finishing Third Place in '#{ @event.title }'!", user_id: event_signup.user_id)
    end
  end
end
