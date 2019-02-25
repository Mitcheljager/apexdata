module ApplicationHelper
  def asset_exist?(path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? path
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end

  def alldata?
    if cookies[:alldata] == "expanded"
      return true
    else
      return false
    end
  end

  def compact?
    if cookies[:viewtype] == "compact"
      return true
    else
      return false
    end
  end

  def theme_dark?
    if cookies[:theme] == "theme_dark"
      return true
    else
      return false
    end
  end

  def theme_light?
    if cookies[:theme] == "theme_light"
      return true
    else
      return false
    end
  end
end
