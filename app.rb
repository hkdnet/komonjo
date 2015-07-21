require 'sinatra'
require 'slim'
require 'slim/include'
require_relative 'lib/mock/slack_mock'

module Komonjo
  # routing
  class App < Sinatra::Base
    get '/' do
      @posts = Komonjo::Mock::SlackMock.chat_logs
      slim :index
    end
  end
end
