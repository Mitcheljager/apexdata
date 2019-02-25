class ThemeController < ApplicationController
  before_action :reset_ad_counter

  def light
    cookies.permanent[:theme] = "theme_light"
    redirect_to request.referer || root_path
  end

  def dark
    cookies.permanent[:theme] = "theme_dark"
    redirect_to request.referer || root_path
  end
end
