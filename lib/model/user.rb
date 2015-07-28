require_relative './profile'

module Komonjo
  module Model
    # slack user
    class User
      ATTRS_WITHOUT_NEST = %i(id name deleted color is_admin is_owner
                              is_primary_owner is_restricted is_ultra_restricted
                              has_2fa has_files)
      ATTRS_WITHOUT_NEST.each { |at| attr_accessor at }
      attr_accessor :profile

      class << self
        def create(hash)
          new.tap do |u|
            hash.each do |key, val|
              u.send(key.to_s + '=', val) if ATTRS_WITHOUT_NEST.include?(key)
            end
            @profile = Profile.create(hash['profile']) if hash['profile']
          end
        end
      end
    end
  end
end
