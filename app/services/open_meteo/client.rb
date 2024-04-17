# frozen_string_literal: true

module OpenMeteo
  # :nodoc: all
  class Client
    BASE_URL = 'https://api.open-meteo.com/v1'

    attr_reader :location

    def initialize(location)
      @location = location
    end

    def current
      params = {
        latitude: location['lat'],
        longitude: location['lon'],
        emperature_unit: 'fahrenheit',
        timezone: 'Asia/Bangkok',
        current: 'temperature_2m,relative_humidity_2m,precipitation,rain,weather_code,wind_speed_10m'
      }

      send_request(:get, 'forecast', params)['current']
    end

    private

    def send_request(http_method, endpoint, params = {})
      connection = Faraday.new(
        url: BASE_URL,
        params:
      )

      response = connection.public_send(http_method, endpoint)
      JSON.parse(response.body)
    end
  end
end
