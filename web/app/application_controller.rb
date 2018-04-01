require 'sinatra'
require 'sinatra/cross_origin'
require_relative './equation'
require 'dotenv/load'

class ApplicationController < Sinatra::Base

  configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  post '/equation' do
    { data: { equation: Equation.parse(request.params['strokes']) }}.to_json
  rescue Equation::InvalidPathDataError
    render_error(message: "There was an error with the data provided")
  rescue Exception => e
    render_error(message: e.message)
  end

  not_found do
    render_error(code: 404, message: "Not Found")
  end

  error do
    render_error
  end

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  def render_error(code: 400, message: "Your request was not valid")
    status(code)
    content_type :json
    { error: { code: code, message: message } }.to_json
  end
end
