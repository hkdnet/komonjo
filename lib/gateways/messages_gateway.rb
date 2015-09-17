require_relative '../models/user'
require_relative '../models/message'
require_relative '../extensions/hash_extensions'
require 'cgi'

module Komonjo
  module Gateway
    # Merge history and users
    class MessagesGateway
      using HashExtensions
      def initialize(history, users)
        @history = history.map { |e| Hash[e.symbolize_keys] }
        @users = users.map do |e|
          ret = Hash[e.symbolize_keys]
          ret[:profile] = Hash[ret[:profile].symbolize_keys]
          ret
        end
      end

      def messages
        @history.map do |e|
          next e unless e[:user]
          Komonjo::Model::Message.create(e).tap do |message|
            message.user = find_user(e[:user])
            message.text = CGI.unescapeHTML(message.text)
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
