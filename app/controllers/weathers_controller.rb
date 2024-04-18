# frozen_string_literal: true

# :nodoc: all
class WeathersController < ApplicationController
  def index
    @locations = Location.all.where.not(weather_data: nil)
  end

  def show
    @location = Location.find_by(name: params[:id])

    if @location.weather_data.nil? || @location.weather_outdated?
      weather_data = OpenMeteo::GetWeather.new(@location).call
      @location.update!(weather_data:)
    end

    @location
  end
end
