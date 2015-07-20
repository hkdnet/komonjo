module Togelack
  module Slack
    class Reader
      attr_reader :api_token
      def initialize(api_token)
        @api_token = api_token
      end
    end
  end
end
