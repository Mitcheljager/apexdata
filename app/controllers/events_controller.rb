class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action do
    unless Flipper.enabled?(:events)
      redirect_to root_path
    end
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.select { |event| event.title.downcase.gsub(" ", "-") == params[:title].downcase }.first
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :data_names, :legends, :start_datetime, :end_datetime)
  end
end
