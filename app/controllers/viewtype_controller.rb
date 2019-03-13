class ViewtypeController < ApplicationController  
  def expanded
    cookies.permanent[:viewtype] = "expanded"
    redirect_to request.referer || root_path
  end

  def compact
    cookies.permanent[:viewtype] = "compact"
    redirect_to request.referer || root_path
  end
end
