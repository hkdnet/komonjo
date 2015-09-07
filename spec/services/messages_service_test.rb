module KomonjoTest
  module Service
    # test for Komonjo::Service::MessagesService
    module ChannelsServiceTest
      describe Komonjo::Service::MessagesService do
        describe 'initialize' do
          it 'should be able to set nil as @api_token' do
            s = Komonjo::Service::MessagesService.new nil
            assert { s.instance_variable_get(:@api_token).nil? }
          end
          it 'should be able to set param as @api_token' do
            s = Komonjo::Service::MessagesService.new :hoge
            assert { s.instance_variable_get(:@api_token) == :hoge }
          end
        end
        describe 'channels' do
          s = Komonjo::Service::MessagesService.new nil
          class << s
            def connection(_)
              Komonjo::Mock::SlackMock
            end
          end
          it 'should be map hash to Komonjo::Model::Message' do
            s.messages(:test_channel).each do |e|
              assert { e.class == Komonjo::Model::Message }
              assert { !(/^id00\d/.match(e.user.id).nil?) }
            end
          end
        end
      end
    end
  end
end
