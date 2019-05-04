module ProfilesHelper
  def profile_path_by_uid(uid)
    profile = ClaimedProfile.find_by_profile_uid_and_checks_completed(uid, 1)

    if profile.present?
      return profile_path(profile.platform, profile.username)
    end
  end
end
