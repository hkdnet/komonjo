require_relative './profile'
require_relative '../extensions/to_json'

module Komonjo
  module Model
    # slack user
    class User
      include Komonjo::Extension::ToJson

      attr_accessor :profile, :id, :name, :deleted, :color, :is_admin,
                    :is_owner, :is_primary_owner, :is_restricted,
                    :is_ultra_restricted, :has_2fa, :has_files

      def self.create(hash)
        new.tap do |e|
          hash.each { |k, v| e.instance_variable_set("@#{k}", v) }
          e.profile = Profile.create(hash[:profile]) if hash[:profile]
        end
      end
    end
  end
end
