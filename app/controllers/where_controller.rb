class WhereController < ApplicationController
  include ContentHelper
  before_action :reset_ad_counter

  def index
    @items = weapons.select { |weapon| weapon[params[:where].underscore.downcase].downcase.gsub(" ", "-") == params[:value].downcase }
  end
end
