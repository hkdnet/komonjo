module Komonjo
  module Gateway
    # test for messages gateway
    module ChannelsGatewayTest
      describe 'channels' do
        it 'should embed users to messages' do
          channels = Komonjo::Mock::SlackMock.channels_list
          g = Komonjo::Gateway::ChannelsGateway.new channels
          g.channels.each do |e|
            assert { e.class == Komonjo::Model::Channel }
            assert { !(/^channel/.match(e.name).nil?) }
          end
        end
      end
    end
  end
end
