require "net/http"
require "uri"
require "json"

module Hitchspots
  # Hitchwiki maps API wrapper
  # Documentation: http://hitchwiki.org/maps/, click API in bottom right corner
  module Hitchwiki
    BASE_URL = "http://hitchwiki.org/maps/api/".freeze

    # Get detail of a spots by it"s ID.
    # doc: http://hitchwiki.org/maps/ => #place_info paragraph
    #
    # @param [String] id ID of spot (Hitchwiki ID)
    #
    # @return [Hash] Spot detail, see test/doubles/responses/spot_example.json
    def self.spot(id)
      uri       = URI(BASE_URL)
      uri.query = URI.encode_www_form(place:  id,
                                      who:    "hitchspots.me",
                                      format: "json")

      res = Net::HTTP.get_response(uri)

      raise ApiError, "Hitchwiki unavailable" if res.code != "200"

      JSON.parse(res.body, symbolize_names: true)
    end

    # Get all the spots in a bounded area.
    # doc: http://hitchwiki.org/maps/ => #places_area paragraph
    #
    # @param [Float|Integer|String] bounds Four coordinates:
    #                                      lat_min, lat_max, lon_min, lon_max
    #
    # @return [Array:Hash] Array of spot hashes, contains
    #         { id: String, lat: String, lon: String, rating: String }
    def self.spots_by_area(*bounds)
      uri       = URI(BASE_URL)
      uri.query = URI.encode_www_form(bounds: bounds.join(","),
                                      who:    "hitchspots.me",
                                      format: "json")

      res = Net::HTTP.get_response(uri)

      raise ApiError, "Hitchwiki unavailable" if res.code != "200"

      JSON.parse(res.body, symbolize_names: true)
    end
  end
end