class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :reset_ad_counter

  $ad_counter = 1

  private

  def reset_ad_counter
    $ad_counter = 1
  end
end
