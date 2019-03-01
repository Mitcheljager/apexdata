module ThemeHelper
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
