ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "minitest/color"
require "rack/test"
require "webmock/minitest"

require "./app"
require_relative "doubles/mocks"

WebMock.disable_net_connect!(allow_localhost: true)
