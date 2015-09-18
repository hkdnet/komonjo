require 'json'

module Komonjo
  module Model
    module API
      # api response base class
      class ResponseBase
        attr_accessor :ok, :message, :data

        def initialize
          @ok = true
          @message = ''
        end

        def to_json
          hash = {}
          hash[:ok] = @ok
          hash[:message] = @message
          hash[:data] = @data
          JSON[hash]
        end
      end
    end
  end
end
