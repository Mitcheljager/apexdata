class ApiController < ApplicationController
  include ContentHelper

  before_action :check_api_key, :set_headers

  rescue_from StandardError do |exception|
    render :json => @error_object.to_json, :status => :unprocessable_entity
  end

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

    @items = eval params[:items].underscore
    @items = @items.sort! { |a,b| b[params[:sort_by].underscore] <=> a[params[:sort_by].underscore] }

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(JSON.parse(@items.to_json()))}
    end
  end

  def category
    @items = eval params[:category].underscore

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

  def set_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "GET"
    headers["Access-Control-Request-Method"] = "*"
    headers["Access-Control-Allow-Headers"] = "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  end
end
