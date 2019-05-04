module NotificationsHelper
  def create_notification(content, go_to = "")
    Notification.create(content: content, go_to: go_to, user_id: current_user.id, has_been_read: 0)
  end
end
