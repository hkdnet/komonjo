module KomonjoTest
  module Service
    # test for Komonjo::Service::SlackService
    module SlackServiceTest
      describe Komonjo::Service::SlackService do
        describe 'connection' do
          it 'should set param to Slack.token' do
            service = Komonjo::Service::SlackService.new
            connection = service.connection(ENV['KOMONJO_SLACK_API_TOKEN'])
            assert { connection.api_token == ENV['KOMONJO_SLACK_API_TOKEN'] }
          end
        end
      end
    end
  end
end
