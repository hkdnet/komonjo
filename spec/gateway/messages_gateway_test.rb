module Komonjo
  module Gateway
    # test for messages gateway
    module MessagesGatewayTest
      describe 'find_user' do
        it 'should return a user by id' do
          u1 = Komonjo::Model::User.create({})
          u2 = Komonjo::Model::User.create({})
          id = 'a_sample_value'
          u1.id = id
          u2.id = 'different_from_u1'
          g = Komonjo::Gateway::MessagesGateway.new nil, [u1, u2]
          found = g.send :find_user, id
          assert { found.id == u1.id }
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
          u1 = Komonjo::Model::User.create({})
          u2 = Komonjo::Model::User.create({})
          u1_id = 'a_sample_value'
          u2_id = 'different_from_u1'
          u1.id = u1_id
          u2.id = u2_id
          m1 = Komonjo::Model::Message.create({})
          m2 = Komonjo::Model::Message.create({})
          m1.user = u1_id
          m2.user = u1_id
          g = Komonjo::Gateway::MessagesGateway.new [m1, m2], [u1, u2]
          g.messages.each do |m|
            assert_equal m.user.class, Komonjo::Model::User
          end
        end
      end
    end
  end
end
