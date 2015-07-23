require 'slack'

module Komonjo
  module Connection
    # Connection for slack
    class SlackConnection
      attr_reader :api_token
      def initialize(api_token)
        @api_token = api_token
        Slack.configure do |config|
          config.token = @api_token
        end
        fail 'connection error' unless auth_test
      end

      def channel_id(channel_name)
        channel_list = Slack.channels_list
        fail 'error' unless channel_list['ok']
        target_channel = channel_list['channels'].select do |c|
          c['name'] == channel_name
        end
        if target_channel.empty?
          fail "unknown channel name: #{channel_name}"
        else
          target_channel.first['id']
        end
      end

      def all_logs_at(channel_name)
        channel_id = channel_id channel_name
        ret = Slack.channels_history(channel: channel_id)
        fail 'error' unless ret['ok']
        ret['messages']
      end

      def user_info(user_id)
        ret = Slack.users_info(user: user_id)
        fail 'error' unless ret['ok']
        ret['user']
      end

      def user_list
        ret = Slack.users_list
        fail 'error' unless ret['ok']
        ret['members']
      end

      private

      def auth_test
        ret = Slack.auth_test
        ret['ok']
      end
    end
  end
end