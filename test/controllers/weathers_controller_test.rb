require 'test_helper'

class WeathersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index with no nil weather_data' do
    get weathers_url

    assert_response :success
  end

  test 'should show weather data for existing location' do
    location = locations(:one)

    get weather_url(location.name)
    location.reload

    assert_response :success
    assert_not_nil location.weather_data
  end

  test 'should update weather data for location if outdated' do
    location = locations(:two)
    location.update(weather_data: { time: [Date.yesterday.to_s] })

    get weather_url(location.name)
    location.reload

    assert_response :success
    assert_equal Date.today.to_s, location.weather_data['time'].first
  end
end
