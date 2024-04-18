# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :weathers

  def weather_outdated?
    weather_data['time'].first != Date.today.to_s
  end
end
