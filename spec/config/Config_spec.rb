require_relative '../spec_helper'
require_relative '../../lib/config/Config'

describe Togelack::Config::ConfigManager do
  describe '#config' do
    it 'should return a hash object' do
      obj = Togelack::Config::ConfigManager.config
      obj.class.must_equal Hash
    end
  end
  describe 'getter' do
    it 'should return value specified by namespace and key' do
      api_token = Togelack::Config::ConfigManager.slack "api_token"
      api_token.class.must_equal String
    end
  end
end
