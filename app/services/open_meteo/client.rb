# frozen_string_literal: true

module OpenMeteo
  # :nodoc: all
  class Client
    BASE_URL = 'https://api.open-meteo.com/v1'

    attr_reader :location

    def initialize(location)
      @location = location
    end

    def weekly
      params = {
        latitude: location['lat'],
        longitude: location['lon'],
        emperature_unit: 'fahrenheit',
        daily: 'weather_code,temperature_2m_max,wind_speed_10m_max'
      }

      send_request(:get, 'forecast', params)['daily']
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
