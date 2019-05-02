class User < ApplicationRecord
  has_secure_password
  has_many :claimed_profiles
  has_many :event_signups

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z\d][a-z\d-]*[a-z\d]\z/i }
  validates :password, presence: true, length: { minimum: 8 }
end
