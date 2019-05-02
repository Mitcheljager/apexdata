class EventSignup < ApplicationRecord
  belongs_to :user

  validates :event_id, presence: true
  validates :user_id, presence: true
  validates :profile_uid, presence: true
end
