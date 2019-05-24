if defined?(Discord)
  Discord::Notifier.setup do |config|
    config.url = ENV["DISCORD_NOTIFICATIONS_WEBHOOK_URL"]
    config.username = "ApexData.gg Notifications"
    config.avatar_url = "https://i.imgur.com/plQNFx1.jpg"

    # Defaults to `false`
    config.wait = true
  end
end
