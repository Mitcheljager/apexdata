class EventLegendData < ApplicationRecord
  validates :event_id, presence: true
  validates :profile_uid, presence: true
  validates :legend, presence: true
end
