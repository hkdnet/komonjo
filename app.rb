require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'slim/include'
require 'compass'
require 'coffee-script'
require_relative 'lib/mocks/slack_mock'
require_relative 'lib/connections/slack_connection'
require_relative 'lib/services/messages_service'

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

    get '/scripts/:name.js' do
      coffee :"coffee/#{params[:name]}"
    end

    get '/' do
      @api_token = ENV['TEST_API_TOKEN'] || ''
      @messages = Komonjo::Mock::SlackMock.chat_logs
      slim :index
    end

    post '/' do
      @api_token = params[:api_token]
      @channel_name = params[:channel_name]
      service = Komonjo::Service::MessagesService.new(@api_token)
      @messages = service.messages @channel_name
      @messages.each { |e| puts e.to_markdown }
      slim :index
    end

    post '/md' do
      @api_token = params[:api_token]
      @channel_name = params[:channel_name]
      service = Komonjo::Service::MessagesService.new(@api_token)
      @messages = service.messages @channel_name
      ret = @messages.take.to_markdown
      p ret
      ret
    end
  end
end
