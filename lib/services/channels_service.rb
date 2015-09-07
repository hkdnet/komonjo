require_relative '../connections/slack_connection'
require_relative '../gateways/channels_gateway'

module Komonjo
  module Service
    # A service for get channels_list as Komonjo::Model::Channel
    class ChannelsService
      def initialize(api_token)
        @api_token = api_token
      end

      def channels
        connection = Komonjo::Connection::SlackConnection.new @api_token
        raw_channels = connection.channels_list
        gateway = Komonjo::Gateway::ChannelsGateway.new raw_channels
        gateway.channels
      end
    end
  end
end
