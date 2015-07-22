require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'slim/include'
require_relative 'lib/mock/slack_mock'

module Komonjo
  # routing
  class App < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    get '/' do
      @posts = Komonjo::Mock::SlackMock.chat_logs
      slim :index
    end
  end
end
