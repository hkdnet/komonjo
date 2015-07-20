require 'mem'
require 'json'

module Togelack
  module Config
    class ConfigManager
      class << self
        include Mem
        def method_missing(name, *args)
          config[name.to_s][args[0]]
        end

        def config
          path = File.expand_path('../../../config.json', __FILE__)
          json = File.read(path)
          JSON.parse json
        end
        memoize :config
      end
    end
  end
end
