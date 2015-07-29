require_relative './user'

module Komonjo
  module Model
    # slacke Message
    class Message
      ATTRS_WITHOUT_NEST = %i(type channel user text ts edited subtype)
      ATTRS_WITHOUT_NEST.each do |at|
        attr_accessor at
      end

      class << self
        def create(hash)
          new.tap do |p|
            hash.each do |key, val|
              p.send(key.to_s + '=', val) if ATTRS_WITHOUT_NEST.include?(key)
            end
          end
        end
      end
      # provide square bracket access
      def [](key)
        send(key)
      end

      def []=(key, val)
        send(key, val)
      end
    end
  end
end
