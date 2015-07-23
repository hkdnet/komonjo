require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'slim/include'
require 'compass'
require_relative 'lib/mock/slack_mock'
require_relative 'lib/adapter/slack_adapter'

module Komonjo
  # routing
  class App < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
      require 'dotenv'
      Dotenv.load
    end

    Compass.configuration do |c|
      c.project_path = File.dirname(__FILE__)
      c.sass_dir = 'views/scss'
    end

    get '/css/:name.css' do
      scss :"scss/#{params[:name]}"
    end

    get '/' do
      @api_token = ENV['TEST_API_TOKEN'] || ''
      @posts = Komonjo::Mock::SlackMock.chat_logs
      slim :index
    end

    post '/' do
      @api_token = params[:api_token]
      @channel_name = params[:channel_name]
      adapter = Komonjo::Adapter::SlackAdapter.new @api_token
      @posts = adapter.all_logs_at @channel_name
      slim :index
    end
  end
end
