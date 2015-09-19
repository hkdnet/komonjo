require 'lib/models/user'

module Komonjo
  module Model
    # slacke channel
    class Channel
      attr_accessor :id, :name, :is_channel, :created, :creator, :is_archived,
                    :is_general, :members, :topic, :purpose, :is_member,
                    :last_read, :latest, :unread_count, :unread_count_display

      def self.create(hash)
        new.tap do |e|
          hash.each { |k, v| e.instance_variable_set("@#{k}", v) }
        end
      end
    end
  end
end
