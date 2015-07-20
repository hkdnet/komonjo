require "slack"

module Togelack
  module Adapter
    class SlackAdapter
      attr_reader :api_token
      def initialize(api_token)
        @api_token = api_token
        Slack.configure do |config|
          config.token = @api_token
        end
        raise 'connection error' unless auth_test
      end

      def channel_id(channel_name)
        channel_list = Slack.channels_list
        raise 'error' unless channel_list["ok"]
        target_channel = channel_list["channels"].select { |c| c["name"] == channel_name}
        if target_channel.empty?
          raise 'unknown channel name: #{channel_name}'
        else
          target_channel.first["id"]
        end
      end

      def all_logs_at(channel_name)
        channel_id = channel_id channel_name
        ret = Slack.channels_history(channel: channel_id)
        raise 'error' unless ret["ok"]
        ret
      end

      private
      def auth_test
        ret = Slack.auth_test
        ret["ok"]
      end
    end
  end
end
