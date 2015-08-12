require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'dotenv'
require 'minitest/power_assert'

Dotenv.load

libs = %w(connections gateways mocks models)
libs.each do |ns|
  Dir[File.expand_path("../../lib/#{ns}", __FILE__) << '/*.rb'].each do |file|
    require file
  end
end

libs.each do |ns|
  Dir[File.expand_path("../#{ns}", __FILE__) << '/*_test.rb'].each do |file|
    require file
  end
end
