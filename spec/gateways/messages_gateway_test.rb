module Komonjo
  module Gateway
    # test for messages gateway
    module MessagesGatewayTest
      describe 'find_user' do
        it 'should return a user by id' do
          users = Komonjo::Mock::SlackMock.users_list
          history = Komonjo::Mock::SlackMock.channels_history 'test'
          u1 = users[0]
          id = u1[:id]
          g = Komonjo::Gateway::MessagesGateway.new history, users
          found = g.send :find_user, id
          assert { found.class == Komonjo::Model::User }
          assert { found.id == id }
        end

        it 'should throw exception with unknown user_id' do
          users = Komonjo::Mock::SlackMock.users_list
          history = Komonjo::Mock::SlackMock.channels_history 'test'
          g = Komonjo::Gateway::MessagesGateway.new history, users
          begin
            g.send :find_user, 'unknown_id'
            assert false, 'this line should not be executed because' \
              'find_user should throw unknown user exception'
          rescue
            assert true
          end
        end
      end

      describe 'messages' do
        it 'should embed users to messages' do
          users = Komonjo::Mock::SlackMock.users_list
          history = Komonjo::Mock::SlackMock.channels_history 'test'
          g = Komonjo::Gateway::MessagesGateway.new history, users
          g.messages.each do |e|
            assert { e.class == Komonjo::Model::Message }
            assert { e.user.class == Komonjo::Model::User }
          end
        end
      end
    end
  end
end
