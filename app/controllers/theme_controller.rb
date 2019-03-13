class ThemeController < ApplicationController
  def light
    cookies.permanent[:theme] = "theme_light"
  end

  def dark
    cookies.permanent[:theme] = "theme_dark"
  end
end
