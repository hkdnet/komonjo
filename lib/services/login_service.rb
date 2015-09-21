require 'lib/services/slack_service'
require 'lib/connections/slack_connection'

module Komonjo
  module Service
    # A service for get channels_list as Komonjo::Model::Channel
    class LoginService < Komonjo::Service::SlackService
      def initialize(api_token)
        @api_token = api_token
      end

      def login
        connection = connection(@api_token)
        connection.auth_test
      end
    end
  end
end
