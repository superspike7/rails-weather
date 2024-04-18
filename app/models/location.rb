# frozen_string_literal: true

class Location < ApplicationRecord
  include Weatherable

  has_many :weathers
end
