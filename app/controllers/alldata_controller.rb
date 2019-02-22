class AlldataController < ApplicationController
  before_action :reset_ad_counter
  
  def expanded
    cookies.permanent[:alldata] = "expanded"
    redirect_to request.referer || root_path
  end

  def compact
    cookies.permanent[:alldata] = "compact"
    redirect_to request.referer || root_path
  end
end
