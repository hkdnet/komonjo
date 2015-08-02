require_relative '../model/user'
require_relative '../model/message'

module Komonjo
  module Gateway
    # Merge history and users
    class MessagesGateway
      def initialize(history, users)
        @history = history
        @users = users
        @history = @history.map do |h|
          Hash[h.map{ |k, v| [k.to_sym, v] }]
        end
        @users = @users.map do |h|
          Hash[h.map{ |k, v| [k.to_sym, v] }]
        end
        @users.each do |u|
          u[:profile] = Hash[u[:profile].map{ |k, v| [k.to_sym, v] }]
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
