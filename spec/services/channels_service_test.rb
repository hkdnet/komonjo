module KomonjoTest
  module Service
    # test for Komonjo::Service::ChannelsService
    module ChannelsServiceTest
      describe Komonjo::Service::ChannelsService do
        describe 'initialize' do
          it 'should be able to set nil as @api_token' do
            s = Komonjo::Service::ChannelsService.new nil
            assert { s.instance_variable_get(:@api_token).nil? }
          end
          it 'should be able to set param as @api_token' do
            s = Komonjo::Service::ChannelsService.new :hoge
            assert { s.instance_variable_get(:@api_token) == :hoge }
          end
        end
        describe 'channels' do
          s = Komonjo::Service::ChannelsService.new nil
          class << s
            def connection(_)
              Komonjo::Mock::SlackMock
            end
          end
          it 'should be map hash to Komonjo::Model::Channel' do
            s.channels.each do |e|
              assert { e.class == Komonjo::Model::Channel }
              assert { !(/^channel/.match(e.name).nil?) }
            end
          end
        end
      end
    end
  end
end
