class User < ApplicationRecord
  has_secure_password

  has_many :claimed_profiles, -> { where checks_completed: 1 }
  has_many :event_signups
  has_many :memberships
  has_many :notifications
  has_many :rewards
  has_many :remember_tokens

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z\d][a-z\d-]*[a-z\d]\z/i }
  validates :password, presence: true, length: { minimum: 8 }
end
