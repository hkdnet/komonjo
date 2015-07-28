module Komonjo
  module Model
    # slack User.profile
    class Profile
      ATTRS_WITHOUT_NEST = %i(first_name last_name real_name email skype
                              phone image_24 image_32 image_48 image_72
                              image_192 )
      ATTRS_WITHOUT_NEST.each do |at|
        attr_accessor at
      end

      def self.create(hash)
        new.tap do |p|
          hash.each do |key, val|
            p.send(key.to_s + '=', val) if ATTRS_WITHOUT_NEST.include?(key)
          end
        end
      end
    end
  end
end
