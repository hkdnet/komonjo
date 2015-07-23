require_relative '../connection/slack_connection'
require_relative '../gateway/message_gateway'

module Komonjo
  module Service
    # A service for merge channel log and user information
    class MessagesService
      def initialize(api_token)
        @api_token = api_token
      end

      def messages(channel_name)
        connection = Komonjo::Connection::SlackConnection.new @api_token
        history = connection.all_logs_at channel_name
        users = connection.user_list
        service = Komonjo::Gateway::MessagesGateway.new history, users
        service.messages
      end
    end
  end
end
