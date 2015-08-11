require_relative '../models/user'
require_relative '../models/message'

module Komonjo
  module Gateway
    # Merge history and users
    class MessagesGateway
      def initialize(history, users)
        @history = history.map { |h| Hash[h.map { |k, v| [k.to_sym, v] }] }
        @users = users.map do |h|
          ret = Hash[h.map { |k, v| [k.to_sym, v] }]
          ret[:profile] = Hash[ret[:profile].map { |k, v| [k.to_sym, v] }]
          ret
        end
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
