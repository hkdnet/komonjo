require 'minitest/autorun'
require 'dotenv'
Dir[File.expand_path('../../lib/connection', __FILE__) << '/*.rb'].each do |file|
  require file
end
Dotenv.load
