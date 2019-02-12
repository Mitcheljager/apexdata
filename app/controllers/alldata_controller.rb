class AlldataController < ApplicationController
  def expanded
    cookies.permanent[:alldata] = "expanded"
    redirect_to request.referer
  end

  def compact
    cookies.permanent[:alldata] = "compact"
    redirect_to request.referer
  end
end
