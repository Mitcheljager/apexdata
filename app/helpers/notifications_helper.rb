module NotificationsHelper
  def create_notification(content, go_to = "", user = current_user.id)
    return unless Flipper.enabled?(:notifications)
    Notification.create(content: content, go_to: go_to, user_id: user, has_been_read: 0)
  end
end
