module ApplicationHelper
  def asset_exists?(path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? path
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end

  def get_username_for_claimed_profile_uid(uid)
    profile = ClaimedProfile.find_by_profile_uid_and_checks_completed(uid, 1)

    if profile.present?
      return profile.username
    end
  end

  def profile_path_by_uid(uid)
    profile = ClaimedProfile.find_by_profile_uid_and_checks_completed(uid, 1)

    if profile.present?
      return profile_path(profile.platform, profile.username)
    end
  end
end
