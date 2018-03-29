require 'sinatra'
require 'sinatra/cross_origin'
require_relative './equation'

class Application < Sinatra::Base
  include Equation

  configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  post '/equation' do
    Equation.parse(request.params['strokes'])
  rescue InvalidPathDataError
    "There was an error with the data provided"
  end

  not_found do
    content_type :json
    { error: { code: 404, message: "Not Found" } }.to_json
  end

  error do
    content_type :json
    { error: { code: 400, message: "your request was not valid" } }.to_json
  end

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end
end
