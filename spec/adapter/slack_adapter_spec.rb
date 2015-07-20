require_relative '../spec_helper'

api_token = ENV["TEST_API_TOKEN"]
unless api_token
  raise <<EOS
    Please set api token before testing.
    The token should be written in .env at project root.
EOS
end


describe Togelack::Adapter::SlackAdapter do
  r = Togelack::Adapter::SlackAdapter.new(api_token)
  describe '#initialize' do
    it 'should set api_token' do
      r.api_token.must_equal api_token
    end
  end
end
