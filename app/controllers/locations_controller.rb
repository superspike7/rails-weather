# frozen_string_literal: true

class LocationsController < ApplicationController
  def index
    locations = Geocoder.search(params[:term]).first(3)
    render json: locations
  end

  def create
    @location = Location.new(location_params)

    if Location.find_by(name: params[:name])
      render json: @location
    elsif @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :lat, :lon)
  end
end
