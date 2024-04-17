# frozen_string_literal: true

# :nodoc: all
class WeathersController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @location = Location.find_by(name: params[:id])

    if @location.weather_data.nil?
      weather_data = OpenMeteo::GetWeather.new(@location).call
      @location.update!(weather_data:)
    else
      @weathers = Weathers.new(@location.weather_data)
    end
  end
end
