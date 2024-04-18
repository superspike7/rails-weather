# frozen_string_literal: true

class LocationsController < ApplicationController
  def index
    locations = Geocoder.search(params[:term]).first(3)
    render json: locations
  end
end
