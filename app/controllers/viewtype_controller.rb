class ViewtypeController < ApplicationController
  def expanded
    cookies.permanent[:viewtype] = "expanded"
    redirect_to request.referer
  end

  def compact
    cookies.permanent[:viewtype] = "compact"
    redirect_to request.referer
  end
end
