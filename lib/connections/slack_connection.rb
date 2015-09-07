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

      def channels_history(channel_name)
        channel_name[0] = '' if channel_name[0] == '#'
        channel_id = channel_id channel_name
        ret = Slack.channels_history(channel: channel_id)
        fail 'error' unless ret['ok']
        ret['messages']
      end

      def users_info(user_id)
        ret = Slack.users_info(user: user_id)
        fail 'error' unless ret['ok']
        ret['user']
      end

      def users_list
        ret = Slack.users_list
        fail 'error' unless ret['ok']
        ret['members']
      end

      def channels_list
        ret = Slack.channels_list
        fail 'error' unless ret['ok']
        ret['channels']
      end

      private

      def auth_test
        ret = Slack.auth_test
        ret['ok']
      end

      def channel_id(channel_name)
        channel_list = Slack.channels_list
        fail 'error' unless channel_list['ok']
        target_channel = channel_list['channels'].select do |e|
          e['name'] == channel_name
        end
        if target_channel.empty?
          fail "unknown channel name: #{channel_name}"
        else
          target_channel.first['id']
        end
      end
    end
  end
end
