require 'lib/services/slack_service'
require 'lib/connections/slack_connection'
require 'lib/gateways/channels_gateway'

module Komonjo
  module Service
    # A service for get channels_list as Komonjo::Model::Channel
    class ChannelsService < Komonjo::Service::SlackService
      def initialize(api_token)
        @api_token = api_token
      end

      def channels
        connection = connection(@api_token)
        raw_channels = connection.channels_list
        gateway = Komonjo::Gateway::ChannelsGateway.new raw_channels
        gateway.channels
      end
    end
  end
end
