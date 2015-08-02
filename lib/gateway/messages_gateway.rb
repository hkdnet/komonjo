require_relative '../model/user'
require_relative '../model/message'

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
          next h unless h[:user]
          Komonjo::Model::Message.create(h).tap do |message|
            message.user = find_user h[:user]
          end
        end
      end

      private

      def find_user(user_id)
        user = @users.find { |u| u[:id] == user_id }
        fail "unknown user: #{user_id}" unless user
        Komonjo::Model::User.create(user)
      end
    end
  end
end
