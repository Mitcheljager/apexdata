class WhereController < ApplicationController
  include ContentHelper

  def index
    @items = weapons.select { |weapon| weapon[params[:where]].downcase == params[:value].downcase }
  end
end
