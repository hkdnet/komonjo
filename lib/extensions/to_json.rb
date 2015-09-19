module Komonjo
  module Extension
    # generate to_json method
    module ToJson
      def to_json(*args)
        ret = instance_variables.each_with_object({}) do |attr, hash|
          # remove head @
          key = attr.to_s
          key[0] = ''
          hash[key.to_sym] = instance_variable_get(attr)
        end
        ret.to_json(*args)
      end
    end
  end
end
