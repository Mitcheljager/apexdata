class ApiController < ApplicationController
  include ContentHelper

  before_action :check_api_key

  def basic
    @items = eval params[:type].underscore

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(JSON.parse(@items.to_json()))}
    end
  end

  def where
    @items = eval params[:type].underscore
    @items = @items.select { |item| item[params[:where].underscore.downcase].downcase.gsub(" ", "-") == params[:value].downcase }

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(JSON.parse(@items.to_json()))}
    end
  end

  def sort
    if params[:items] == "all"
      params[:items] = "weapons"
    end

    items = eval params[:items].underscore

    if items.any?
      @items = items.sort! { |a,b| b[params[:sort_by].underscore] <=> a[params[:sort_by].underscore] }
    end

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(JSON.parse(@items.to_json()))}
    end
  end

  private

  def check_api_key
    valid_api_key = User.find_by_api_key(params[:key])

    unless valid_api_key
      render json: "API Key is not valid", status: :unauthorized
    end
  end
end
