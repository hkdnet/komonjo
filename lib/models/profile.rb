module Komonjo
  module Model
    # slack User.profile
    class Profile
      attr_accessor :first_name, :last_name, :real_name, :email, :skype, :phone,
                    :image_24, :image_32, :image_48, :image_72, :image_192

      def self.create(hash)
        new.tap { |e| hash.each { |k, v| e.instance_variable_set("@#{k}", v) } }
      end
    end
  end
end
