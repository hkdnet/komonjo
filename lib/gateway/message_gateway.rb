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
          if h['user']
            user = @users.find { |u| u['id'] == h['user'] }
            fail "unknown user #{h['user']}" unless user
            h['username'] = user['name']
            h['icon_url'] = user['profile']['image_48']
            puts h['user'], user, h['username']
          end
          h
        end
      end
    end
  end
end
