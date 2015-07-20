require 'sinatra'
require 'slim'

module Komonjo
  # routing
  class App < Sinatra::Base
    get '/' do
      slim :index
    end
  end
end
