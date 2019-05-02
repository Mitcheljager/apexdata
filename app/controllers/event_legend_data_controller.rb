class EventLegendDataController < ApplicationController
  before_action :set_event_legend_data, only: [:update]
  before_action do
    unless Flipper.enabled?(:events)
      redirect_to root_path
    end
  end

  def create
    @event_legend_data = EventLegendData.new(event_legend_data_params)
  end

  def update
  end

  private

  def set_event_legend_data
    @event_legend_data = EventLegendData.find(params[:id])
  end

  def event_legend_data_params
    params.require(:event_legend_data).permit(:event_id, :profile_uid, :legend, :initial_value, :current_value)
  end
end
