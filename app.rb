require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'slim/include'
require 'compass'
require 'coffee-script'

require 'lib/mocks/slack_mock'
require 'lib/services/messages_service'
require 'lib/services/channels_service'
require 'lib/services/login_service'
require 'lib/models/api/response_base'

module Komonjo
  # routing
  class App < Sinatra::Base
    enable :sessions

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

    get '/api/login' do
      content_type :json
      res = Komonjo::Model::API::ResponseBase.new
      res.data = session[:api_token]
      res.to_json
    end

    post '/api/login' do
      content_type :json
      res = Komonjo::Model::API::ResponseBase.new
      api_token = params[:api_token] || ''
      if api_token != ''
        service = Komonjo::Service::LoginService.new(api_token)
        if service.login
          session[:api_token] = api_token
        else
          res.ok = false
          res.message = 'ERROR: api_token is invalid.'
        end
      else
        res.ok = false
        res.message = 'ERROR: api_token is required.'
      end
      res.to_json
    end

    get '/api/channels' do
      content_type :json
      res = Komonjo::Model::API::ResponseBase.new
      puts session[:api_token]
      api_token = session[:api_token] || ''
      if !api_token.nil? && api_token != ''
        channels_service = Komonjo::Service::ChannelsService.new(api_token)
        res.data = channels_service.channels.map(&:name)
      else
        res.ok = false
        res.message = 'ERROR: api_token is required.'
      end
      res.to_json
    end

    get '/api/messages' do
      content_type :json
      res = Komonjo::Model::API::ResponseBase.new
      api_token = session[:api_token] || ''
      channel_name = params[:channel_name] || ''
      if api_token != '' && channel_name != ''
        messages_service = Komonjo::Service::MessagesService.new(api_token)
        res.data = messages_service.messages(channel_name)
      else
        res.ok = false
        res.message = 'ERROR: api_token and channel_name are required.'
      end
      res.to_json
    end

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
