module Komonjo
  module Gateway
    # test for messages gateway
    module MessagesGatewayTest
      describe 'find_user' do
        it 'should return a user by id' do
          users = Komonjo::Mock::SlackMock.users
          u1 = users[0]
          u2 = users[1]
          id = u1[:id]
          g = Komonjo::Gateway::MessagesGateway.new nil, [u1, u2]
          found = g.send :find_user, id
          assert { found.class == Komonjo::Model::User }
          assert { found.id == id }
        end

        it 'should throw exception with unknown user_id' do
          u1 = Komonjo::Model::User.create({})
          u2 = Komonjo::Model::User.create({})
          u1.id = 'a_sample_value'
          u2.id = 'different_from_u1'
          g = Komonjo::Gateway::MessagesGateway.new nil, [u1, u2]
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
          users = Komonjo::Mock::SlackMock.users
          history = Komonjo::Mock::SlackMock.history 'test'
          g = Komonjo::Gateway::MessagesGateway.new history, users
          g.messages.each do |m|
            assert { m.class == Komonjo::Model::Message }
            assert { m.user.class == Komonjo::Model::User }
          end
        end
      end
    end
  end
end
