class CompareController < ApplicationController
  include ContentHelper

  def index
    @first_compare = weapons.select { |weapon| weapon["name"].downcase == params[:first].downcase }
    @second_compare = weapons.select { |weapon| weapon["name"].downcase == params[:second].downcase }
  end
end
