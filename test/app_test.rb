require_relative "test_helper"

class AppTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    stub_request(:get, %r{https\:\/\/nominatim\.openstreetmap\.org\/search\?.*})
      .to_return(status: 200,
                 body: File.read("#{__dir__}/doubles/responses/osm_example.json"))

    stub_request(:get, %r{https\:\/\/api\.mapbox\.com\/directions\/v5\/mapbox\/driving\/.*})
      .to_return(status: 200,
                 body: File.read("#{__dir__}/doubles/responses/mapbox_example.json"))

    stub_request(:get, %r{https\:\/\/hitchwiki\.org\/maps\/api\/\?country=FI.*})
      .to_return(status: 200,
                 body: File.read("#{__dir__}/doubles/responses/all_spots_example.json"))
  end

  def test_home
    get "/"

    assert last_response.ok?
  end

  def test_trip
    get "/trip", from: "Paris", to: "Berlin"

    assert last_response.ok?
  end

  def test_country
    get "/country", name: "Finland", iso_code: "FI"

    assert last_response.ok?
  end
end
