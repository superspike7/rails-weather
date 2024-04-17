# frozen_string_literal: true

# :nodoc: all
class WeathersController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    location = Geocoder.search('manila').first.data

    @current = OpenMeteo::Client.new(location).current
  end
end
