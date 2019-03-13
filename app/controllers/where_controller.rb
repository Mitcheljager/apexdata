class WhereController < ApplicationController
  include ContentHelper

  def index
    @items = weapons.select { |weapon| weapon[params[:where].underscore.downcase].downcase.gsub(" ", "-") == params[:value].downcase }
  end
end
