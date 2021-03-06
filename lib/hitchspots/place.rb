require "json"
require "erb"
require "time"

module Hitchspots
  # Place Value object
  class Place
    attr_reader :name, :lat, :lon

    def initialize(name = nil, lat: nil, lon: nil)
      @name = name
      @lat = lat == "" ? nil : lat # replace empty strings by nil
      @lon = lon == "" ? nil : lon # replace empty strings by nil
    end

    def short_name
      name&.split(", ")&.first
    end
  end
end
