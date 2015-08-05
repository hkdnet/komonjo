require_relative '../gateway/messages_gateway'
module Komonjo
  module Mock
    # Mock for SlackConnection
    class SlackMock
      class << self
        def chat_logs
          g = Komonjo::Gateway::MessagesGateway.new history('test'), users
          g.messages
        end

        def users
          [{ id: 'id001', name: 'name001', deleted: false,
             profile: { image_48: '' } },
           { id: 'id002', name: 'name002', deleted: false,
             profile: { image_48: '' } }]
        end

        def history(channel_name)
          [{ type: 'message', user: 'id001', channel: channel_name },
           { type: 'message', user: 'id002', channel: channel_name }]
        end
      end
    end
  end
end
