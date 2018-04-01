#!/usr/bin/env ruby
require './app/application_controller'
require 'minitest/autorun'
require 'minitest/unit'
require 'mocha/minitest'
require 'rack/test'
require 'json'

ENV['RACK_ENV'] = 'test'

class RouteTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    ApplicationController
  end

  def test_root_path
    get '/'
    assert_equal 404, last_response.status
  end

  def test_parsing_error
    post '/equation', {"strokes": "DANK"}
    assert_equal 400, last_response.status
    assert last_response.body.include?('There was an error with the data provided')
  end

  def test_parsing_successful
    Equation.stubs(:parse).returns('\\sin x')
    post '/equation', {"strokes": "SCG_INK\n1\n2\n1 3\n4 5\n"}
    assert_equal '\\sin x', JSON.parse(last_response.body)['data']['equation']
  end

  def test_seshat_error
    Equation.stubs(:seshat_file).returns('Error: this is a test')
    post '/equation', {"strokes": "SCG_INK\n1\n2\n1 3\n4 5\n"}
    assert_equal 400, last_response.status
    assert_equal 'Error: this is a test', JSON.parse(last_response.body)['error']['message']
  end
end
