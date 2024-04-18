# frozen_string_literal: true

module Weatherable
  extend ActiveSupport::Concern

  included do
    def current
      Weather.new(
        code: weather_data['weather_code'][0],
        date: weather_data['time'][0],
        temperature: weather_data['temperature_2m_max'][0],
        wind: weather_data['wind_speed_10m_max'][0]
      )
    end

    def upcoming
      (1..6).map do |index|
        Weather.new(
          code: weather_data['weather_code'][index],
          date: weather_data['time'][index],
          temperature: weather_data['temperature_2m_max'][index],
          wind: weather_data['wind_speed_10m_max'][index]
        )
      end
    end

    def weather_outdated?
      return true if weather_data.nil?

      weather_data['time'].first != Date.today.to_s
    end
  end
end
