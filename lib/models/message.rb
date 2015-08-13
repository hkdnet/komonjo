require_relative './user'

module Komonjo
  module Model
    # slacke Message
    class Message
      attr_accessor :type, :channel, :user, :text, :ts, :edited, :subtype

      def self.create(hash)
        new.tap do |e|
          hash.each { |k, v| e.instance_variable_set("@#{k}", v) }
        end
      end
    end
  end
end
