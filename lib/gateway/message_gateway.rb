module Komonjo
  module Gateway
    # Merge history and users
    class MessagesGateway
      def initialize(history, users)
        @history = history
        @users = users
      end

      def messages
        @history.map do |h|
          return h unless h['user']
          user = user h['user']
          h.tap do |hist|
            hist['username'] = user['name']
            hist['icon_url'] = user['profile']['image_48']
          end
        end
      end

      def user(user_id)
        user = @users.find { |u| u['id'] == user_id }
        fail "unknown user #{h['user']}" unless user
        user
      end
    end
  end
end
