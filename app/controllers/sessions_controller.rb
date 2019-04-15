class SessionsController < ApplicationController
  before_action do
    unless Flipper.enabled?(:users)
      redirect_to root_path
    end
  end

  def new
  end

  def create
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to account_path
    else
      flash.now[:alert] = "Username or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
