require 'test_helper'

class WeatherableTest < ActiveSupport::TestCase
  class TestWeatherable
    include Weatherable

    attr_accessor :weather_data

    def initialize(weather_data)
      @weather_data = weather_data
    end
  end

  def setup
    @weatherable = TestWeatherable.new(weather_data)
  end

  def weather_data
    dates = (Date.today..Date.today + 7).map(&:to_s)

    {
      'time' => dates,
      'weather_code' => [0, 0, 0, 0, 0, 0, 0],
      'temperature_2m_max' => [5.2, 5.2, 5.2, 5.2, 5.2, 5.2, 5.2],
      'wind_speed_10m_max' => [5.2, 5.2, 5.2, 5.2, 5.2, 5.2, 5.2]
    }
  end

  test 'current method should return correct weather object' do
    current_weather = @weatherable.current
    assert_equal 0, current_weather.code
    assert_equal Date.today.to_s, current_weather.date
    assert_equal 5.2, current_weather.temperature
    assert_equal(5.2, current_weather.wind)
  end

  test 'upcoming method should return array of upcoming weather objects' do
    upcoming_weather = @weatherable.upcoming
    assert_equal 6, upcoming_weather.size

    upcoming_weather.each_with_index do |weather, index|
      assert_equal 0, weather.code
      assert_equal (Date.today + index + 1).to_s, weather.date
      assert_equal 5.2, weather.temperature
      assert_equal(5.2, weather.wind)
    end
  end

  test 'weather_outdated? should return true if weather data is nil' do
    @weatherable.weather_data = nil
    assert @weatherable.weather_outdated?
  end

  test "weather_outdated? should return true if today's date doesn't match the first date in weather data" do
    @weatherable.weather_data['time'][0] = (Date.today - 1).to_s
    assert @weatherable.weather_outdated?
  end

  test "weather_outdated? should return false if today's date matches the first date in weather data" do
    refute @weatherable.weather_outdated?
  end
end
