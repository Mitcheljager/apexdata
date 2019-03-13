class SortController < ApplicationController
  include ContentHelper

  def index
    if params[:items] == "all"
      params[:items] = "weapons"
    end

    items = eval params[:items].underscore

    if items.any?
      @items = items.sort! { |a,b| b[params[:sort_by].underscore] <=> a[params[:sort_by].underscore] }
    end
  end
end
