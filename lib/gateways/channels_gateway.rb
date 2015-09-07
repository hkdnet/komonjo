require_relative '../models/channel'
require_relative '../extensions/hash_extensions'

module Komonjo
  module Gateway
    # Merge history and users
    class ChannelsGateway
      using HashExtensions
      def initialize(channels)
        @channels = channels.map { |e| Hash[e.symbolize_keys] }
      end

      def channels
        @channels.map { |e| Komonjo::Model::Channel.create(e) }
      end
    end
  end
end
