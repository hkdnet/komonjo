require 'lib/models/user'
require 'lib/extensions/to_json'

module Komonjo
  module Model
    # slacke Message
    class Message
      include Komonjo::Extension::ToJson
      attr_accessor :type, :channel, :user, :text, :ts, :edited, :subtype
      # for jsonize
      attr_reader :markdown
      alias_method :to_json_org, :to_json

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

      def to_json(*args)
        @markdown = to_markdown
        to_json_org(args)
      end
    end
  end
end
