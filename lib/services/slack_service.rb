require 'lib/connections/slack_connection'

module Komonjo
  module Service
    # A base class for Service of Slack
    class SlackService
      def connection(api_token)
        Komonjo::Connection::SlackConnection.new(api_token)
      end
    end
  end
end
