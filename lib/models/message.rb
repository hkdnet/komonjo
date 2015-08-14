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

      def timestamp
        Time.at(@ts.to_f).strftime('%Y-%m-%d %H:%M:%S')
      end

      def to_markdown
        icon_markdown + name_markdown + ts_markdown + text_markdown
      end

      def icon_markdown
        "* ![#{@user.name} icon](#{@user.profile.image_48})\n"
      end

      def name_markdown
        "\t- #{@user.name}\n"
      end

      def ts_markdown
        "\t- #{timestamp}\n"
      end

      def text_markdown
        "\t- #{@text}\n"
      end
    end
  end
end
