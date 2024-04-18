require 'test_helper'

class WeatherTest < ActiveSupport::TestCase
  def setup
    @weather = Weather.new(
      code: 0,
      date: '2024-04-18',
      temperature: 25.0,
      wind: 6.9
    )
  end

  test 'should return correct day of the week' do
    assert_equal 'Thursday', @weather.day
  end

  test 'should return correct weather description' do
    assert_equal 'Sunny', @weather.description
  end

  test 'should return correct icon URL' do
    assert_equal 'http=>//openweathermap.org/img/wn/01d@2x.png', @weather.icon_url
  end
end
