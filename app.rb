require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'slim/include'
require 'compass'
require_relative 'lib/mock/slack_mock'

module Komonjo
  # routing
  class App < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    Compass.configuration do |c|
      c.project_path = File.dirname(__FILE__)
      c.sass_dir = 'views/scss'
    end

    get '/css/:name.css' do
      scss :"scss/#{params[:name]}"
    end

    get '/' do
      @posts = Komonjo::Mock::SlackMock.chat_logs
      slim :index
    end
  end
end
