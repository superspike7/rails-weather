# frozen_string_literal: true

class Location < ApplicationRecord
  include Weatherable

  validates_presence_of :name, :lat, :lon
  has_many :weathers
end
