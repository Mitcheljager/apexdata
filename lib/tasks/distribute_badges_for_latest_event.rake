desc "Distribute Badges for event"
task :distribute_badges_for_event, [:event_id, :participation_badge_id] => :environment do |task, args|
  distribute_badges_get_event(args.event_id)

  @event.event_signups.each do |event_signup|
    @badge = DistributedBadge.new(profile_uid: event_signup.profile_uid, badge_id: args.participation_badge_id)
    @badge.save
  end
end

def distribute_badges_get_event(event_id)
  @event = Event.find(event_id)
end
