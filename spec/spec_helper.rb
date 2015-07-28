require 'minitest/autorun'
require 'dotenv'
require 'minitest/power_assert'

Dotenv.load

libs = %w(connection gateway mock model)
libs.each do |ns|
  Dir[File.expand_path("../../lib/#{ns}", __FILE__) << '/*.rb'].each do |f|
    require f
  end
end

libs.each do |ns|
  Dir[File.expand_path("../#{ns}", __FILE__) << '/*_test.rb'].each do |f|
    require f
  end
end
