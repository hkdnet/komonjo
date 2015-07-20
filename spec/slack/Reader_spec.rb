require_relative '../spec_helper'
require_relative '../../lib/slack/reader'
require 'dotenv'
Dotenv.load

api_token = ENV["TEST_API_TOKEN"]
unless api_token
  raise <<EOS
    Please set api token before testing.
    The token should be written in .env at project root.
EOS
end


describe Togelack::Slack::Reader do
  r = Togelack::Slack::Reader.new(api_token)
  describe '#initialize' do
    it 'should set api_token' do
      r.api_token.must_equal api_token
    end
  end
end
