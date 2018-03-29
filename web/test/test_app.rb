#!/usr/bin/env ruby
require './app/app'
require 'minitest/autorun'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class RouteTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_root_path
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('bl')
  end
end
