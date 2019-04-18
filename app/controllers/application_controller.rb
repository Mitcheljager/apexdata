class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  helper_method :membership

  def membership
    if current_user
      @membership = Membership.where("created_at > ?", 1.month.ago).find_by_user_id(current_user.id)
    end
  end
end
