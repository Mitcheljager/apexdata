class BadgesController < ApplicationController
  before_action :set_badge, only: [:edit, :update, :destroy]

  before_action do
    redirect_to account_path unless current_user && current_user.level == 100
  end

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def edit
  end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to badges_path, notice: "Badge was successfully created."
    else
      render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to badges_path, notice: "Badge was successfully updated."
    else
      render :edit
    end
  end

  private
    def set_badge
      @badge = Badge.find(params[:id])
    end

    def badge_params
      params.require(:badge).permit(:title, :description, :image)
    end
end
