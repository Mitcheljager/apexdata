class CompareController < ApplicationController
  include ContentHelper
  before_action :reset_ad_counter

  def index
    @first_compare = weapons.select { |weapon| weapon["name"].downcase == params[:first].downcase }
    @second_compare = weapons.select { |weapon| weapon["name"].downcase == params[:second].downcase }
  end
end
