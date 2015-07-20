require 'minitest/autorun'
require 'dotenv'
Dir[File.expand_path('../../lib/adapter', __FILE__) << '/*.rb'].each { |file| require file }
Dotenv.load
