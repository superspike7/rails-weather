# frozen_string_literal: true

class Location < ApplicationRecord
  include Weatherable

  validates_presence_of :name, :lat, :lon
  validate :name_snake_case

  has_many :weathers

  private

  def name_snake_case
    return if name =~ /\A[a-z0-9_]+\z/

    errors.add(:name, 'must be in snake_case format')
  end
end
