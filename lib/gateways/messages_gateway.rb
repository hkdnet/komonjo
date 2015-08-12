require_relative '../models/user'
require_relative '../models/message'

module Komonjo
  module Gateway
    # Merge history and users
    class MessagesGateway
      def initialize(history, users)
        @history = history.map { |e| Hash[e.map { |k, v| [k.to_sym, v] }] }
        @users = users.map do |e|
          ret = Hash[e.map { |k, v| [k.to_sym, v] }]
          ret[:profile] = Hash[ret[:profile].map { |k, v| [k.to_sym, v] }]
          ret
        end
      end

      def messages
        @history.map do |e|
          next e unless e[:user]
          Komonjo::Model::Message.create(e).tap do |message|
            message.user = find_user(e[:user])
          end
        end
      end

      private

      def find_user(user_id)
        user = @users.find { |e| e[:id] == user_id }
        fail "unknown user: #{user_id}" unless user
        Komonjo::Model::User.create(user)
      end
    end
  end
end
