require 'minitest/autorun'
require 'dotenv'
Dir[File.expand_path('../../lib/connection', __FILE__) << '/*.rb'].each do |f|
  require f
end
Dir[File.expand_path('../../lib/model', __FILE__) << '/*.rb'].each do |f|
  require f
end
Dotenv.load
