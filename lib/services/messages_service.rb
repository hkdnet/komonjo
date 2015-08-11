require_relative '../connections/slack_connection'
require_relative '../gateways/messages_gateway'

module Komonjo
  module Service
    # A service for merge channel log and user information
    class MessagesService
      def initialize(api_token)
        @api_token = api_token
      end

      def messages(channel_name)
        connection = Komonjo::Connection::SlackConnection.new @api_token
        history = connection.channels_history channel_name
        users = connection.users_list
        gateway = Komonjo::Gateway::MessagesGateway.new history, users
        gateway.messages
      end
    end
  end
end
