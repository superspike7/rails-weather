# frozen_string_literal: true

# :nodoc: all
class Weather
  include WeatherHelper
  attr_reader :code, :temperature, :wind, :date

  def initialize(code:, date:, temperature:, wind:)
    @code = code
    @date = date
    @temperature = temperature
    @wind = wind
  end

  def day
    Date.parse(date).strftime('%A')
  end

  def description
    MWO_CODE[code.to_s]['day']['description']
  end

  def icon_url
    MWO_CODE[code.to_s]['day']['image']
  end
end
