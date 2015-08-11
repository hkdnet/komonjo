module KomonjoTest
  module Model
    # test for Komonjo::Connection::SlackConnection
    module SlackConnectionTest
      api_token = ENV['TEST_API_TOKEN']
      unless api_token
        fail 'Please set api token before testing.' \
          'The token should be written in .env at project root.'
      end
      describe Komonjo::Connection::SlackConnection do
        r = Komonjo::Connection::SlackConnection.new(api_token)
        describe '#initialize' do
          it 'should set api_token' do
            r.api_token.must_equal api_token
          end
        end
      end
    end
  end
end
