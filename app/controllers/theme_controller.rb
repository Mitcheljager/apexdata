class ThemeController < ApplicationController
  before_action :reset_ad_counter

  def light
    cookies.permanent[:theme] = "theme_light"
  end

  def dark
    cookies.permanent[:theme] = "theme_dark"
  end
end
