# frozen_string_literal: true

# :nodoc: all
class Weathers
  def initialize(data)
    @data = data.with_indifferent_access
  end

  def current
    Weather.new(
      code: @data[:weather_code][0],
      date: @data[:time][0],
      temperature: @data[:temperature_2m_max][0],
      wind: @data[:wind_speed_10m_max][0]
    )
  end

  def upcoming
    (1..6).map do |index|
      Weather.new(
        code: @data[:weather_code][index],
        date: @data[:time][index],
        temperature: @data[:temperature_2m_max][index],
        wind: @data[:wind_speed_10m_max][index]
      )
    end
  end
end
