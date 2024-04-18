require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test 'should not save location without name' do
    location = Location.new(lat: 40.7128, lon: -74.0060)
    assert_not location.save, 'Saved the location without a name'
  end

  test 'should not save invalid name' do
    location = Location.new(name: 'New York', lat: 40.7128, lon: -74.0060)
    assert_not location.save, 'Did not save a valid location'
    assert_equal 'Name must be in snake_case format', location.errors.full_messages.first
  end

  test 'should not save location without latitude' do
    location = Location.new(name: 'New York', lon: -74.0060)
    assert_not location.save, 'Saved the location without latitude'
  end

  test 'should not save location without longitude' do
    location = Location.new(name: 'New York', lat: 40.7128)
    assert_not location.save, 'Saved the location without longitude'
  end
end
