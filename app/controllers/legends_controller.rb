class LegendsController < ApplicationController
  include ContentHelper
  before_action :reset_ad_counter

  def index
  end

  def show
    @item = legend(params[:name])
  end
end
