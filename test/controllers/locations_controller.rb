require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    term = 'New York'
    get locations_url, params: { term: }, as: :json
    assert_response :success

    locations = JSON.parse(response.body)
    assert_not_empty locations
  end

  test 'should create location' do
    location_params = { name: 'New York', lat: 40.7128, lon: -74.0060 }

    assert_difference('Location.count') do
      post locations_url, params: { location: location_params }, as: :json
    end

    assert_response :created
    assert_equal location_params[:name], JSON.parse(response.body)['name']
  end

  test 'should return existing location if found' do
    existing_location = locations(:one)

    assert_no_difference('Location.count') do
      post locations_url, params: { name: existing_location.name }, as: :json
    end

    assert_response :success
    assert_equal existing_location.name, JSON.parse(response.body)['name']
  end

  test 'should return unprocessable_entity if location not saved' do
    invalid_params = { name: '' }

    assert_no_difference('Location.count') do
      post locations_url, params: { location: invalid_params }, as: :json
    end

    assert_response :unprocessable_entity
  end
end
