require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'slim/include'
require 'compass'
require 'coffee-script'
require_relative 'lib/mocks/slack_mock'
require_relative 'lib/connections/slack_connection'
require_relative 'lib/services/messages_service'
require_relative 'lib/services/channels_service'
require_relative 'api'
require_relative 'mount'

module Komonjo
  # routing
  class App < Sinatra::Base
    register Sinatra::Mount

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

    get '/scripts/:name.js' do
      coffee :"coffee/#{params[:name]}"
    end

    mount API, '/api/'

    get '/' do
      @api_token = ENV['KOMONJO_SLACK_API_TOKEN'] || ''
      if @api_token != ''
        channels_service = Komonjo::Service::ChannelsService.new(@api_token)
        @channels = channels_service.channels.map(&:name)
      else
        @channels = []
      end
      @messages = Komonjo::Mock::SlackMock.chat_logs
      slim :index
    end

    post '/' do
      @api_token = params[:api_token]
      @channel_name = params[:channel_name]
      channels_service = Komonjo::Service::ChannelsService.new(@api_token)
      @channels = channels_service.channels.map(&:name)
      messages_service = Komonjo::Service::MessagesService.new(@api_token)
      @messages = messages_service.messages @channel_name
      slim :index
    end
  end
end
