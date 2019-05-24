class LegendsController < ApplicationController
  include ContentHelper

  def index
    
  end

  def show
    @item = legend(params[:name])
  end
end
