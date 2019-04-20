class Admin::BaseController < ApplicationController
  before_action do
    redirect_to login_path unless current_user
  end
end
