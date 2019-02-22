class ViewtypeController < ApplicationController
  before_action :reset_ad_counter
  
  def expanded
    cookies.permanent[:viewtype] = "expanded"
    redirect_to request.referer || root_path
  end

  def compact
    cookies.permanent[:viewtype] = "compact"
    redirect_to request.referer || root_path
  end
end
